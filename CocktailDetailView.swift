//
//  CocktailDetailView.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 9.09.2024.
//

import SwiftUI

struct CocktailDetailView: View {
    @EnvironmentObject var viewModel: CocktailViewModel
    var id: String
    
    var body: some View {
        VStack(spacing: 16) {
            if let cocktail = viewModel.cocktailDetail {
                ScrollView {
                    VStack(alignment: .center, spacing: 10) {
                        AsyncImage(url: URL(string: cocktail.imageUrl)) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 300, height: 300)
                                .cornerRadius(10.0)
                                .shadow(radius: 5.0)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(cocktail.name)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            Text("categoryTitle" + " \(cocktail.category)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            if let glass = cocktail.glass {
                                Text("glassTitle" + " \(glass)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            } else {
                                Text("glassTitleNoInfo")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            if let alcoholic = cocktail.alcoholic {
                                Text("alcoholTypeTitle" + " \(alcoholic)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            } else {
                                Text("alcoholTypeTitleNoInfo")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Divider()
                            
                            Text("instructionsTitle")
                                .font(.headline)
                            if let instructions = cocktail.instructions {
                                Text(instructions)
                                    .padding(.bottom)
                            } else {
                                Text("defaultNoInfo")
                                    .padding(.bottom)
                            }
                            
                            Text("ingredientsTitle")
                                .font(.headline)
                            if let ingredient1 = cocktail.ingredient1, let ingredient2 = cocktail.ingredient2 {
                                Text("\(ingredient1), \(ingredient2)")
                            } else {
                                Text("defaultNoInfo")
                            }
                        }
                        .padding()
                        
                        Button(action: {
                            viewModel.addToBasket(cocktail: cocktail)
                        }) {
                            Text("addToBasketButtonText")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(10.0)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .padding(.horizontal)
                        .padding(.bottom)
                    }
                    .padding()
                }
            } else {
                ProgressView("progressCocktailDetails")
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchCocktailDetail(by: id)
            }
        }
        .applyGradientBackground()
        .navigationTitle("navTitleCocktailDetails")
        .navigationBarTitleDisplayMode(.inline)
    }
}
