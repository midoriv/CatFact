//
//  CatFactViewModel.swift
//  CatFact
//
//  Created by Midori Verdouw on 17/1/22.
//

import Foundation
import Combine
import SwiftUI

class CatFactViewModel: ObservableObject {
    @Published private(set) var loadState: LoadState = .idle
    @Published private(set) var catFacts = [CatFact]()
    @Published var favourites = [CatFact]() {
        didSet {
            storeInUserDefaults()
        }
    }
    @Published var currentFactIndex = 0
    
    private let apiClient = CatFactAPIClient()
    
    
    init() {
        restoreFromUserDefaults()
    }
    
    
    // MARK: - UserDefaults
    private var userDefaultsKey = "Favourites"
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(favourites), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedFavourites = try? JSONDecoder().decode(Array<CatFact>.self, from: jsonData) {
            favourites = decodedFavourites
        }
    }
    
    
    // MARK: - Intent(s)
    
    func loadCatFacts() async {
        self.loadState = .loading
        print("Loading")
        
        do {
            let catFacts = try await apiClient.loadCatFacts()
            
            DispatchQueue.main.async { [weak self] in
                self?.loadState = .loaded
                self?.catFacts += catFacts
            }
        }
        catch {
            DispatchQueue.main.async { [weak self] in
                self?.loadState = .failed(error)
                print("Error: \(error)")
            }
        }
    }
    
    // a timer used for changing current fact index every 5 seconds
    private var timer: Timer?
    
    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] timer in
            if let weakSelf = self {
                let collection = weakSelf.slideShowMode == SlideShowMode.favourite ? weakSelf.favourites : weakSelf.catFacts
                
                if collection.count > 0 {
                    weakSelf.currentFactIndex = (weakSelf.currentFactIndex + 1) % collection.count
                }
                else {
                    timer.invalidate()
                }
            }
        }
    }
    
    func addFavourite(_ catFact: CatFact) {
        favourites.append(catFact)
    }
    
    func clearCatFacts() {
        if !catFacts.isEmpty {
            catFacts.removeAll()
        }
    }
    
    func setCurrentFactIndex(_ index: Int) {
        currentFactIndex = index
    }
    
    // MARK: - Slide show
    var slideShowMode = SlideShowMode.random
    
    enum SlideShowMode: Equatable {
        case random
        case favourite
    }
    
    func setSlideShowMode(_ mode: SlideShowMode) {
        self.slideShowMode = mode
    }
}
