//
//  CocktailModel.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 6.09.2024.
//

import Foundation

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

struct FilteredCocktailListResponse: Decodable {
    let drinks: [FilteredCocktail]
}
