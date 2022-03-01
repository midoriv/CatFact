//
//  NotificationManager.swift
//  CatFact
//
//  Created by Midori Verdouw on 3/2/2022.
//

import Foundation
import UserNotifications

final class NotificationManager: ObservableObject {
    @Published private(set) var authorizationStatus: UNAuthorizationStatus?
    
    init() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            // if a notification hasn't been created yet
            if notifications.isEmpty {
                self.createLocalNotification() { error in
                    if error == nil {
                    }
                }
            }
        }
    }
    
    func reloadAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.authorizationStatus = settings.authorizationStatus
            }
        }
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { isGranted, _ in
            DispatchQueue.main.async {
                self.authorizationStatus = isGranted ? .authorized : .denied
            }
        }
    }
    
    // create a local notification of a cat fact at 10 AM daily
    func createLocalNotification(completion: @escaping (Error?) -> Void) {
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        Task {
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = "Today's Cat Fact"
            notificationContent.sound = .default
            notificationContent.body = await getCatFact()
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: completion)
        }
    }
        
    func getCatFact() async -> String {
        let apiClient = CatFactAPIClient()
        
        if let catFact = try? await apiClient.loadCatFact() {
            return catFact.fact
        }
        else {
            return ""
        }
    }
}
