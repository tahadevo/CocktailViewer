//
//  CocktailViewModel.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 6.09.2024.
//

import Foundation

class CocktailViewModel: ObservableObject {
    @Published private var model = CocktailModel()
    @Published private(set) var isLoading: Bool = false
    private let repository: CocktailRepository
        
    init(repository: CocktailRepository = CocktailRepository()) {
        self.repository = repository
    }
    
    var cocktails: [Cocktail] {
        return model.cocktails
    }
    
    var searchedCocktails: [Cocktail] {
        return model.searchedCocktails
    }
    
    var categories: [String] {
        return model.categories
    }
    
    var ingredients: [String] {
        return model.ingredients
    }
    
    var savedCocktails: [CocktailDetail] {
        return model.savedCocktails
    }
    
    var basket: [CocktailDetail] {
        return model.basket
    }
    
    var filteredCocktails: [FilteredCocktail] {
        return model.filteredCocktails
    }
    
    var cocktailDetail: CocktailDetail? {
        return model.cocktailDetail
    }
    
    func initializeData() async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask {
                await self.fetchCocktails()
            }
            group.addTask {
                await self.fetchCategories()
            }
            group.addTask {
                await self.fetchIngredients()
            }
        }
    }

    func fetchCocktails() async {
        DispatchQueue.main.async { self.isLoading = true }
        let fetchedCocktails = await repository.fetchCocktails()
        DispatchQueue.main.async { [self] in
            model.setCocktails(cocktails: fetchedCocktails)
            self.isLoading = false
        }
    }
    
    func fetchCocktailsByName(searchTerm: String) async {
        DispatchQueue.main.async { self.isLoading = true }
        let fetchedCocktails = await repository.fetchCocktailsByName(searchTerm: searchTerm)
        DispatchQueue.main.async { [self] in
            model.setSearchedCocktails(cocktails: fetchedCocktails)
            self.isLoading = false
        }
    }
    
    func fetchCategories() async {
        DispatchQueue.main.async { self.isLoading = true }
        let fetchedCategories = await repository.fetchCategories()
        DispatchQueue.main.async { [self] in
            model.setCategories(categories: fetchedCategories)
            self.isLoading = false
        }
    }
    
    func fetchIngredients() async {
        DispatchQueue.main.async { self.isLoading = true }
        let fetchedIngredients = await repository.fetchIngredients()
        DispatchQueue.main.async { [self] in
            model.setIngredients(ingredients: fetchedIngredients)
            self.isLoading = false
        }
    }
    
    func fetchCocktailsByCategory(category: String) async {
        DispatchQueue.main.async { self.isLoading = true }
        let fetchedCocktails = await repository.fetchCocktailsByCategory(category: category)
        DispatchQueue.main.async { [self] in
            model.setFilteredCocktails(filteredCocktails: fetchedCocktails)
            self.isLoading = false
        }
    }
    
    func fetchCocktailsByIngredient(ingredient: String) async {
        DispatchQueue.main.async { self.isLoading = true }
        let fetchedCocktails = await repository.fetchCocktailsByIngredient(ingredient: ingredient)
        DispatchQueue.main.async { [self] in
            model.setFilteredCocktails(filteredCocktails: fetchedCocktails)
            self.isLoading = false
        }
    }
    
    func fetchCocktailDetail(by id: String) async {
        DispatchQueue.main.async { self.isLoading = true }
        let fetchedCocktail = await repository.fetchCocktailDetail(by: id)
        DispatchQueue.main.async { [self] in
            model.setCocktailDetail(cocktailDetail: fetchedCocktail)
            self.isLoading = false
        }
    }
    
    func saveCocktailsToSaved() {
        model.saveCocktailsToSaved()
    }
    
    func removeSavedCocktail(at index: Int) {
        model.removeSavedCocktail(at: index)
    }
    
    func addToBasket(cocktail: CocktailDetail) {
        model.addToBasket(cocktail: cocktail)
    }
    
    func removeFromBasket(at index: Int) {
        model.removeFromBasket(at: index)
    }
    
    func clearSavedCocktails() {
        model.clearSavedCocktails()
    }
    
    func clearSearchedCocktails() {
        model.clearSearchedCocktails()
    }
}
