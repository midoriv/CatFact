//
//  CatFactViewModel.swift
//  CatFact
//
//  Created by Midori Verdouw on 17/1/22.
//

import Foundation
import Combine

class CatFactViewModel: ObservableObject {
    @Published private(set) var loadState: LoadState = .idle
    @Published private(set) var catFacts = [CatFact]()
    @Published var currentFactIndex = 0
    
    private var cancellables = Set<AnyCancellable>()
    private let apiClient = CatFactAPIClient()
    
    
    // MARK: - Intent(s)
    
    func loadCatFacts() async {
        self.loadState = .loading
        print("Loading")
        
        do {
            let catFacts = try await apiClient.loadCatFacts()
            
            DispatchQueue.main.async { [weak self] in
                self?.loadState = .loaded
                self?.catFacts = catFacts
                print("Loaded")
            }
        }
        catch {
            DispatchQueue.main.async { [weak self] in
                self?.loadState = .failed(error)
                print("Error: \(error)")
            }
        }
    }
    
    func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] timer in
            if let weakSelf = self {
                weakSelf.currentFactIndex = (weakSelf.currentFactIndex + 1) % weakSelf.catFacts.count
            }
        }
    }
}
