//
//  CocktailModel.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 6.09.2024.
//

import Foundation

struct CocktailModel {
    private(set) var cocktails: [Cocktail] = []
    private(set) var searchedCocktails: [Cocktail] = []
    private(set) var categories: [String] = []
    private(set) var ingredients: [String] = []
    
    private(set) var savedCocktails: [CocktailDetail] = []
    private(set) var basket: [CocktailDetail] = []
    
    private(set) var filteredCocktails: [FilteredCocktail] = []
    private(set) var cocktailDetail: CocktailDetail?
    
    init() {
        savedCocktails = retrieveSavedCocktails()
    }
    
    mutating func setCocktails(cocktails: [Cocktail]) {
        self.cocktails = cocktails
    }
    
    mutating func setSearchedCocktails(cocktails: [Cocktail]) {
        self.searchedCocktails = cocktails
    }
    
    mutating func setCategories(categories: [String]) {
        self.categories = categories
    }
    
    mutating func setIngredients(ingredients: [String]) {
        self.ingredients = ingredients
    }
    
    mutating func setFilteredCocktails(filteredCocktails: [FilteredCocktail]) {
        self.filteredCocktails = filteredCocktails
    }
    
    mutating func setCocktailDetail(cocktailDetail: CocktailDetail?) {
        self.cocktailDetail = cocktailDetail
    }
    
    mutating func saveCocktailsToSaved() {
        savedCocktails.append(contentsOf: basket)
        basket.removeAll()
        saveCocktailsToUserDefaults()
    }
    
    mutating func removeSavedCocktail(at index: Int) {
        savedCocktails.remove(at: index)
        saveCocktailsToUserDefaults()
    }
    
    mutating func addToBasket(cocktail: CocktailDetail) {
        basket.append(cocktail)
    }
    
    mutating func removeFromBasket(at index: Int) {
        basket.remove(at: index)
    }
    
    mutating func clearSavedCocktails() {
        savedCocktails.removeAll()
        saveCocktailsToUserDefaults()
    }
    
    mutating func clearSearchedCocktails() {
        searchedCocktails.removeAll()
    }
    
    private func saveCocktailsToUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(savedCocktails) {
            UserDefaults.standard.set(encoded, forKey: Configuration.userDefaultsKey)
        }
    }
    
    private func retrieveSavedCocktails() -> [CocktailDetail] {
        if let savedData = UserDefaults.standard.data(forKey: Configuration.userDefaultsKey) {
            let decoder = JSONDecoder()
            if let loadedCocktails = try? decoder.decode([CocktailDetail].self, from: savedData) {
                return loadedCocktails
            }
        }
        
        return []
    }
}

struct Cocktail: Identifiable, Codable {
    let id: String
    let name: String
    let category: String
    let instructions: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case category = "strCategory"
        case instructions = "strInstructions"
        case imageUrl = "strDrinkThumb"
    }
}

struct FilteredCocktail: Identifiable, Codable {
    let id: String
    let name: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case imageUrl = "strDrinkThumb"
    }
}

struct CocktailDetail: Identifiable, Codable {
    let id: String
    let name: String
    let category: String
    let instructions: String?
    let imageUrl: String
    let alcoholic: String?
    let glass: String?
    let tags: String?
    let ingredient1: String?
    let ingredient2: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case category = "strCategory"
        case instructions = "strInstructions"
        case imageUrl = "strDrinkThumb"
        case alcoholic = "strAlcoholic"
        case glass = "strGlass"
        case tags = "strTags"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
    }
}

struct CategoryListResponse: Decodable {
    let drinks: [Category]
}

struct Category: Decodable {
    let strCategory: String
}

struct IngredientListResponse: Decodable {
    let drinks: [Ingredient]
}

struct Ingredient: Decodable {
    let strIngredient1: String
}

struct CocktailResponse: Decodable {
    let drinks: [Cocktail]?
}

struct FilteredCocktailListResponse: Decodable {
    let drinks: [FilteredCocktail]?
}

struct CocktailDetailResponse: Decodable {
    let drinks: [CocktailDetail]?
}

enum Tab {
    case home, search, basket, profile
}

enum HomeNavigation: Hashable {
    case cocktailDetail(id: String)
    case category(String)
    case ingredient(String)
}

enum SearchNavigation: Hashable {
    case cocktailDetail(id: String)
}

enum BasketNavigation: Hashable {
    case cocktailDetail(id: String)
}

enum ProfileNavigation: Hashable {
    case savedCocktails
    case cocktailDetail(id: String)
}
