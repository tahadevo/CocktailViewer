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
