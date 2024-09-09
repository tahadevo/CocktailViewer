//
//  SavedCocktailsView.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 9.09.2024.
//

import SwiftUI

struct SavedCocktailsView: View {
    @EnvironmentObject var viewModel: CocktailViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.savedCocktails.indices, id: \.self) { index in
                    CocktailCardView(cocktail: viewModel.savedCocktails[index]) {
                        // no "add to basket"
                    }
                    .padding(.vertical, 5)
                }
                .onDelete(perform: removeSavedCocktail)
            }
            .navigationTitle("Saved Cocktails")
            .background(Color(.systemGroupedBackground))
        }
    }
    
    func removeSavedCocktail(at offsets: IndexSet) {
        offsets.forEach { index in
            viewModel.removeSavedCocktail(at: index)
        }
    }
}

//#Preview {
//    SavedCocktailsView(viewModel: CocktailViewModel())
//}
