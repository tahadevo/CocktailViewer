//
//  CocktailRepository.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 19.09.2024.
//

import Foundation

class CocktailRepository {
    func fetchCocktails() async -> [Cocktail] {
        guard let url = URL(string: Configuration.apiSearchURL) else {
            print("Invalid URL")
            return []
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(CocktailResponse.self, from: data)
            return decodedResponse.drinks ?? []
        } catch {
            print("Failed to fetch cocktails: \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchCocktailsByName(searchTerm: String) async -> [Cocktail] {
        guard let url = URL(string: "\(Configuration.apiSearchURL)\(searchTerm)") else {
            print("Invalid URL")
            return []
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(CocktailResponse.self, from: data)
            return decodedResponse.drinks ?? []
        } catch {
            print("Failed to fetch cocktails: \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchCategories() async -> [String] {
        guard let url = URL(string: Configuration.apiCategoryListURL) else {
            print("Invalid URL")
            return []
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(CategoryListResponse.self, from: data)
            return decodedResponse.drinks.map { $0.strCategory }
        } catch {
            print("Failed to fetch categories: \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchIngredients() async -> [String] {
        guard let url = URL(string: Configuration.apiIngredientListURL) else {
            print("Invalid URL")
            return []
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(IngredientListResponse.self, from: data)
            return decodedResponse.drinks.map { $0.strIngredient1 }
        } catch {
            print("Failed to fetch categories: \(error.localizedDescription)")
            return []
        }

    }
    
    func fetchCocktailsByCategory(category: String) async -> [FilteredCocktail] {
        guard let url = URL(string: "\(Configuration.apiCategoryFilterURL)\(category.replacingOccurrences(of: " ", with: "_"))") else {
            print("Invalid URL")
            return []
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(FilteredCocktailListResponse.self, from: data)
            return decodedResponse.drinks ?? []
        } catch {
            print("Failed to fetch category-filtered cocktails: \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchCocktailsByIngredient(ingredient: String) async -> [FilteredCocktail] {
        guard let url = URL(string: "\(Configuration.apiIngredientFilterURL)\(ingredient)") else {
            print("Invalid URL")
            return []
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(FilteredCocktailListResponse.self, from: data)
            return decodedResponse.drinks ?? []
        } catch {
            print("Failed to fetch ingredient-filtered cocktails: \(error.localizedDescription)")
            return []
        }
    }
    
    func fetchCocktailDetail(by id: String) async -> CocktailDetail? {
        guard let url = URL(string: "\(Configuration.apiCocktailDetailURL)\(id)") else {
            print("Invalid URL")
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(CocktailDetailResponse.self, from: data)
            return decodedResponse.drinks?.first
        } catch {
            print("Failed to fetch cocktail detail: \(error.localizedDescription)")
            return nil
        }
    }
}
