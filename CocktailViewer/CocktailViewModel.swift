//
//  CocktailViewModel.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 6.09.2024.
//

import Foundation
import Combine

class CocktailViewModel: ObservableObject {
    @Published var cocktails: [Cocktail] = []
    private var cancellables = Set<AnyCancellable>()
    private let baseUrl = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s="
    private let apiKey = "1"
    
    func fetchCocktails(searchTerm: String) {
        guard let url = URL(string: "\(baseUrl)\(searchTerm)") else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [String: [Cocktail]].self, decoder: JSONDecoder())
            .map { $0["drinks"] ?? [] }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { [weak self] cocktails in
                self?.cocktails = cocktails
            })
            .store(in: &cancellables)
    }
}
