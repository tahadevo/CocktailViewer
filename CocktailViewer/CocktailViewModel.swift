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
    @Published var searchedCocktails: [Cocktail] = []
    @Published var categories: [String] = []
    @Published var ingredients: [String] = []
    
    @Published var savedCocktails: [CocktailDetail] = []
    @Published var basket: [CocktailDetail] = []
    
    @Published var filteredCocktails: [FilteredCocktail] = []
    @Published var cocktailDetail: CocktailDetail?

    private let userDefaultsKey = "savedCocktails"
    private var cancellables = Set<AnyCancellable>()
    private let baseUrl = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s="
    
    init() {
        fetchCocktails(searchTerm: "")
        fetchCategories()
        fetchIngredients()
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
                searchTerm == "" ? (self?.cocktails = cocktails) : (self?.searchedCocktails = cocktails)
            })
            .store(in: &cancellables)
    }
    
    func fetchCategories() {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/list.php?c=list") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            
            if let categoryResponse = try? JSONDecoder().decode(CategoryListResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.categories = categoryResponse.drinks.map { $0.strCategory }
                }
            }
        }.resume()
    }
    
    func fetchIngredients() {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            
            if let ingredientResponse = try? JSONDecoder().decode(IngredientListResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.ingredients = ingredientResponse.drinks.map { $0.strIngredient1 }
                }
            }
        }.resume()
    }
    
    func fetchCocktailsByCategory(category: String) {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=\(category.replacingOccurrences(of: " ", with: "_"))") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            
            if let cocktailResponse = try? JSONDecoder().decode(FilteredCocktailListResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.filteredCocktails = cocktailResponse.drinks
                }
            }
        }.resume()
    }
    
    func fetchCocktailsByIngredient(ingredient: String) {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?i=\(ingredient)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            
            if let cocktailResponse = try? JSONDecoder().decode(FilteredCocktailListResponse.self, from: data) {
                DispatchQueue.main.async {
                    self.filteredCocktails = cocktailResponse.drinks
                }
            }
        }.resume()
    }
    
    func fetchCocktailDetail(by id: String) {
        let urlString = "https://thecocktaildb.com/api/json/v1/1/lookup.php?i=\(id)"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: CocktailDetailResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching cocktail details: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] response in
                self?.cocktailDetail = response.drinks.first
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
    
    func addToBasket(cocktail: CocktailDetail) {
        basket.append(cocktail)
    }
    
    func removeFromBasket(cocktail: CocktailDetail) {
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
            if let loadedCocktails = try? decoder.decode([CocktailDetail].self, from: savedData) {
                savedCocktails = loadedCocktails
            }
        }
    }
}
