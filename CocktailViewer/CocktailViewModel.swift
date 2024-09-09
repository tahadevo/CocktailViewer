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
    @Published var savedCocktails: [Cocktail] = []
    @Published var basket: [Cocktail] = []
    @Published var showOverlay: Bool = false
    @Published var selectedCocktail: Cocktail?

    private let userDefaultsKey = "savedCocktails"
    private var cancellables = Set<AnyCancellable>()
    private let baseUrl = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s="
    private let apiKey = "1"
    
    let categories: [String] = ["Classic", "Tropical", "Non-Alcoholic", "Signature", "Hello"]
    
    init() {
        fetchCocktails(searchTerm: "")
        loadSavedCocktails()
    }
    
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
    
    func saveCocktailsToSaved() {
        savedCocktails.append(contentsOf: basket)
        basket.removeAll()
        saveCocktailsToUserDefaults()
    }
    
    func removeSavedCocktail(at index: Int) {
        savedCocktails.remove(at: index)
        saveCocktailsToUserDefaults()
    }
    
    func showAddToBasketOverlay(cocktail: Cocktail) {
        selectedCocktail = cocktail
        showOverlay = true
    }
    
    func addToBasket(cocktail: Cocktail) {
        basket.append(cocktail)
        showOverlay = false
    }
    
    func removeFromBasket(cocktail: Cocktail) {
        basket.removeAll { $0.id == cocktail.id }
    }
    
    func clearSavedCocktails() {
        savedCocktails.removeAll()
        saveCocktailsToUserDefaults()
    }
    
    private func saveCocktailsToUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(savedCocktails) {
            UserDefaults.standard.set(encoded, forKey: userDefaultsKey)
        }
    }
    
    private func loadSavedCocktails() {
        if let savedData = UserDefaults.standard.data(forKey: userDefaultsKey) {
            let decoder = JSONDecoder()
            if let loadedCocktails = try? decoder.decode([Cocktail].self, from: savedData) {
                savedCocktails = loadedCocktails
            }
        }
    }
}
