//
//  CatFactViewModel.swift
//  CatFact
//
//  Created by Midori Verdouw on 17/1/22.
//

import Foundation
import Combine

class CatFactViewModel: ObservableObject {
    @Published private(set) var loadState: LoadState<CatFact> = .idle
    private var cancellables = Set<AnyCancellable>()
    private let repository = CatFactDataRepository()
    
    func loadCatFact() {
        repository.fetchCatFact()
            .handleEvents(receiveSubscription: { [weak self] _ in
                print("loading")
                self?.loadState = .loading
            })
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        print("Error: \(error)")
                        self?.loadState = .failed(error)
                    case .finished:
                        print("Finished")
                    }
                },
                receiveValue: { [weak self] catFact in
                    self?.loadState = .loaded(catFact)
                    print(catFact)
                }
            )
            .store(in: &cancellables)
    }
}
