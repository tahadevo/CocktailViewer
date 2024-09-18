//
//  Configuration.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 18.09.2024.
//

import Foundation

struct Configuration {
    static var apiBaseURL: String {
        guard let url = Bundle.main.infoDictionary?["APIBaseURL"] as? String else {
            fatalError("APIBaseURL not found in plist")
        }
        return url
    }
    
    static var apiSearchURL: String {
        guard let url = Bundle.main.infoDictionary?["APISearchURL"] as? String else {
            fatalError("APISearchURL not found in plist")
        }
        return url
    }
    
    static var apiCategoryListURL: String {
        guard let url = Bundle.main.infoDictionary?["APICategoryListURL"] as? String else {
            fatalError("APICategoryListURL not found in plist")
        }
        return url
    }
    
    static var apiCategoryFilterURL: String {
        guard let url = Bundle.main.infoDictionary?["APICategoryFilterURL"] as? String else {
            fatalError("APICategoryFilterURL not found in plist")
        }
        return url
    }
    
    static var apiIngredientListURL: String {
        guard let url = Bundle.main.infoDictionary?["APIIngredientListURL"] as? String else {
            fatalError("APIIngredientListURL not found in plist")
        }
        return url
    }
    
    static var apiIngredientFilterURL: String {
        guard let url = Bundle.main.infoDictionary?["APIIngredientFilterURL"] as? String else {
            fatalError("APIIngredientFilterURL not found in plist")
        }
        return url
    }
    
    static var apiCocktailDetailURL: String {
        guard let url = Bundle.main.infoDictionary?["APICocktailDetailURL"] as? String else {
            fatalError("APICocktailDetailURL not found in plist")
        }
        return url
    }
    
    static var userDefaultsKey: String {
        guard let url = Bundle.main.infoDictionary?["UserDefaultsKey"] as? String else {
            fatalError("UserDefaultsKey not found in plist")
        }
        return url
    }
}
