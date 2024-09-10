//
//  FilteredCocktailsListView.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 10.09.2024.
//

import SwiftUI

enum FilterType {
    case category
    case ingredient
}

struct FilteredCocktailsListView: View {
    @EnvironmentObject var viewModel: CocktailViewModel
    var filterType: FilterType
    var filterValue: String
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        let titleStr = filterType == FilterType.category ? "Cocktails in \(filterValue) Category" : "Cocktails with \(filterValue)"
        
        VStack {
            Text(titleStr)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)

            if viewModel.filteredCocktails.isEmpty {
                Text("No cocktails found.")
                    .multilineTextAlignment(.leading)
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(viewModel.filteredCocktails, id: \.id) { cocktail in
                                FilteredCocktailCardView(cocktail: cocktail)
                                    .frame(maxHeight: .infinity)
                        }
                    }
                }
                .padding()
            }
        }
        .applyGradientBackground()
        .onAppear {
            switch filterType {
            case .category:
                viewModel.fetchCocktailsByCategory(category: filterValue)
            case .ingredient:
                viewModel.fetchCocktailsByIngredient(ingredient: filterValue)
            }
        }
    }
}
