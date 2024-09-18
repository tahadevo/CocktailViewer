//
//  CocktailViewModel.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 6.09.2024.
//

import Foundation

class CocktailViewModel: ObservableObject {
    @Published private(set) var cocktails: [Cocktail] = []
    @Published private(set) var searchedCocktails: [Cocktail] = []
    @Published private(set) var categories: [String] = []
    @Published private(set) var ingredients: [String] = []
    
    @Published private(set) var savedCocktails: [CocktailDetail] = []
    @Published private(set) var basket: [CocktailDetail] = []
    
    @Published private(set) var filteredCocktails: [FilteredCocktail] = []
    @Published private(set) var cocktailDetail: CocktailDetail?
    
    @Published private(set) var isLoading: Bool = false

    private let userDefaultsKey = "savedCocktails"
    private let baseUrl = "https://www.thecocktaildb.com/api/json/v1/1/"
    
    init() {
        loadSavedCocktails()
    }
    
    func initializeData() async {
        await fetchCocktails(searchTerm: "")
        await fetchCategories()
        await fetchIngredients()
    }
    
    func fetchCocktails(searchTerm: String) async {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        guard let url = URL(string: "\(baseUrl)search.php?s=\(searchTerm)") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(CocktailResponse.self, from: data)
            DispatchQueue.main.async {
                searchTerm == "" ? (self.cocktails = decodedResponse.drinks ?? []) : (self.searchedCocktails = decodedResponse.drinks ?? [])
                self.isLoading = false
            }
        } catch {
            print("Failed to fetch cocktails: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
    
    func fetchCategories() async {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        guard let url = URL(string: "\(baseUrl)list.php?c=list") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(CategoryListResponse.self, from: data)
            DispatchQueue.main.async {
                self.categories = decodedResponse.drinks.map { $0.strCategory }
                self.isLoading = false
            }
        } catch {
            print("Failed to fetch categories: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
    
    func fetchIngredients() async {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        guard let url = URL(string: "\(baseUrl)list.php?i=list") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(IngredientListResponse.self, from: data)
            DispatchQueue.main.async {
                self.ingredients = decodedResponse.drinks.map { $0.strIngredient1 }
                self.isLoading = false
            }
        } catch {
            print("Failed to fetch categories: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }

    }
    
    func fetchCocktailsByCategory(category: String) async {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        guard let url = URL(string: "\(baseUrl)filter.php?c=\(category.replacingOccurrences(of: " ", with: "_"))") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(FilteredCocktailListResponse.self, from: data)
            DispatchQueue.main.async {
                self.filteredCocktails = decodedResponse.drinks ?? []
                self.isLoading = false
            }
        } catch {
            print("Failed to fetch category-filtered cocktails: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
    
    func fetchCocktailsByIngredient(ingredient: String) async {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        guard let url = URL(string: "\(baseUrl)filter.php?i=\(ingredient)") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(FilteredCocktailListResponse.self, from: data)
            DispatchQueue.main.async {
                self.filteredCocktails = decodedResponse.drinks ?? []
                self.isLoading = false
            }
        } catch {
            print("Failed to fetch ingredient-filtered cocktails: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
    
    func fetchCocktailDetail(by id: String) async {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        guard let url = URL(string: "\(baseUrl)lookup.php?i=\(id)") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(CocktailDetailResponse.self, from: data)
            DispatchQueue.main.async {
                self.cocktailDetail = decodedResponse.drinks?.first
                self.isLoading = false
            }
        } catch {
            print("Failed to fetch cocktail detail: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
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
    
    func removeFromBasket(at index: Int) {
        basket.remove(at: index)
    }
    
    func clearSavedCocktails() {
        savedCocktails.removeAll()
        saveCocktailsToUserDefaults()
    }
    
    func clearSearchedCocktails() {
        searchedCocktails.removeAll()
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
