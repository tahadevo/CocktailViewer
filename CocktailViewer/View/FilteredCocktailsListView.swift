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
    @State private var isLandscape: Bool = UIDevice.current.orientation.isLandscape
    var filterType: FilterType
    var filterValue: String
    
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    let landscapeColumns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        let titleStr = filterType == FilterType.category ?
            String(localized: "filterCategoryTitle", table: nil, bundle: .main, comment: "") + " \(filterValue)" :
            String(localized: "filterIngredientTitle", table: nil, bundle: .main, comment: "") + " \(filterValue)"
        
        VStack {
            if viewModel.filteredCocktails.isEmpty {
                Text("noCocktailsFoundMessage")
                    .multilineTextAlignment(.center)
            } else {
                ScrollView {
                    LazyVGrid(columns: isLandscape ? landscapeColumns : columns, spacing: 10) {
                        ForEach(viewModel.filteredCocktails) { cocktail in
                            NavigationLink(value: HomeNavigation.cocktailDetail(id: cocktail.id)) {
                                FilteredCocktailCardView(cocktail: cocktail)
                                    .frame(maxHeight: .infinity)
                            }
                        }
                    }
                }
                .padding()
            }
        }
        .applyGradientBackground()
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(titleStr)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .minimumScaleFactor(0.8)
            }
        }
        .onRotate { newOrientation in
            isLandscape = newOrientation.isLandscape
        }
        .onAppear {
            switch filterType {
            case .category:
                Task {
                    await viewModel.fetchCocktailsByCategory(category: filterValue)
                }
            case .ingredient:
                Task {
                    await viewModel.fetchCocktailsByIngredient(ingredient: filterValue)
                }
            }
        }
    }
}
