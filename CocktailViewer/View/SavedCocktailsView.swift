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
        VStack {
            List {
                ForEach(viewModel.savedCocktails, id: \.id) { cocktail in
                    NavigationLink(value: ProfileNavigation.cocktailDetail(id: cocktail.id)) {
                        HStack {
                            AsyncImage(url: URL(string: cocktail.imageUrl)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(8)
                                    .padding(.trailing)
                            } placeholder: {
                                ProgressView()
                            }
                            
                            Spacer()
                            
                            Text(cocktail.name)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            Text(cocktail.category)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .frame(maxWidth: 100, alignment: .leading)
                            
                            Spacer()
                            
                            Button(action: {
                                removeCocktailFromSaved(cocktail: cocktail)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                                    .padding(.leading)
                            }
                            .buttonStyle(BorderlessButtonStyle())
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .applyGradientBackground()
        .navigationTitle("navTitleSavedCocktails")
    }
    
    func removeCocktailFromSaved(cocktail: CocktailDetail) {
        if let index = viewModel.savedCocktails.firstIndex(where: { $0.id == cocktail.id }) {
            viewModel.removeSavedCocktail(at: index)
        }
    }
}
