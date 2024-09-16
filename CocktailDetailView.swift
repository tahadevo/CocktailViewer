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
                            
                            Text("Category: \(cocktail.category)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            
                            if let glass = cocktail.glass {
                                Text("Glass: \(glass)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            } else {
                                Text("Glass: No info")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            if let alcoholic = cocktail.alcoholic {
                                Text("Alcohol Type: \(alcoholic)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            } else {
                                Text("Alcohol Type: No info")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            
                            Divider()
                            
                            Text("Instructions")
                                .font(.headline)
                            if let instructions = cocktail.instructions {
                                Text(instructions)
                                    .padding(.bottom)
                            } else {
                                Text("No info")
                                    .padding(.bottom)
                            }
                            
                            Text("Ingredients")
                                .font(.headline)
                            if let ingredient1 = cocktail.ingredient1, let ingredient2 = cocktail.ingredient2 {
                                Text("\(ingredient1), \(ingredient2)")
                            } else {
                                Text("No info")
                            }
                        }
                        .padding()
                        
                        Button(action: {
                            viewModel.addToBasket(cocktail: cocktail)
                        }) {
                            Text("Add to Basket")
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
                ProgressView("Loading cocktail details...")
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchCocktailDetail(by: id)
            }
        }
        .applyGradientBackground()
        .navigationTitle("Cocktail Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
