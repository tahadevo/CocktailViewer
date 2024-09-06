//
//  CocktailModel.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 6.09.2024.
//

import Foundation

struct Cocktail: Identifiable, Decodable {
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
