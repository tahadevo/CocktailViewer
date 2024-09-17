//
//  CocktailDetailView.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 9.09.2024.
//

import SwiftUI

struct CocktailDetailView: View {
    @EnvironmentObject var viewModel: CocktailViewModel
    @State private var isLandscape: Bool = UIDevice.current.orientation.isLandscape
    var id: String
    
    var body: some View {
        VStack(spacing: 16) {
            if let cocktail = viewModel.cocktailDetail {
                ScrollView {
                    if isLandscape {
                        HStack(alignment: .center, spacing: 20) {
                            imageProvider(imageUrl: cocktail.imageUrl)
                            
                            VStack(alignment: .leading) {
                                Text(cocktail.name)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                
                                HStack(alignment: .top, spacing: 15) {
                                    cocktailPrimaryDetails(cocktail: cocktail)
                                    cocktailInstructionsAndButton(cocktail: cocktail)
                                }
                                .padding(.bottom, 10)
                                
                                buttonProvider(cocktail: cocktail)
                            }
                        }
                        .padding()
                    } else {
                        VStack(spacing: 10) {
                            imageProvider(imageUrl: cocktail.imageUrl)
                            
                            Text(cocktail.name)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            
                            cocktailPrimaryDetails(cocktail: cocktail)
                            Divider()
                            cocktailInstructionsAndButton(cocktail: cocktail)
                            
                            buttonProvider(cocktail: cocktail)
                        }
                        .padding()
                    }
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
        .onRotate { newOrientation in
            isLandscape = newOrientation.isLandscape
        }
        .applyGradientBackground()
        .navigationTitle("navTitleCocktailDetails")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private func imageProvider(imageUrl: String) -> some View {
        AsyncImage(url: URL(string: imageUrl)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: isLandscape ? 225 : 300, height: isLandscape ? 225 : 300)
                .cornerRadius(10.0)
                .shadow(radius: 5.0)
        } placeholder: {
            ProgressView()
        }
    }
    
    @ViewBuilder
    private func buttonProvider(cocktail: CocktailDetail) -> some View {
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
    
    @ViewBuilder
    private func cocktailPrimaryDetails(cocktail: CocktailDetail) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(String(localized: "categoryTitle", table: nil, bundle: .main, comment: "") + " \(cocktail.category)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            if let glass = cocktail.glass {
                Text(String(localized: "glassTitle", table: nil, bundle: .main, comment: "") + " \(glass)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            } else {
                Text("glassTitleNoInfo")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if let alcoholic = cocktail.alcoholic {
                Text(String(localized: "alcoholTypeTitle", table: nil, bundle: .main, comment: "") + " \(alcoholic)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            } else {
                Text("alcoholTypeTitleNoInfo")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            if isLandscape {
                Text("ingredientsTitle")
                    .font(.headline)
                if let ingredient1 = cocktail.ingredient1, let ingredient2 = cocktail.ingredient2 {
                    Text("\(ingredient1), \(ingredient2)")
                } else {
                    Text("defaultNoInfo")
                }
            }
        }
    }
    
    @ViewBuilder
    private func cocktailInstructionsAndButton(cocktail: CocktailDetail) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            if !isLandscape {
                Text("ingredientsTitle")
                    .font(.headline)
                if let ingredient1 = cocktail.ingredient1, let ingredient2 = cocktail.ingredient2 {
                    Text("\(ingredient1), \(ingredient2)")
                } else {
                    Text("defaultNoInfo")
                }
            }
            
            Text("instructionsTitle")
                .font(.headline)
            
            if let instructions = cocktail.instructions {
                Text(instructions)
                    .padding(.bottom)
            } else {
                Text("defaultNoInfo")
                    .padding(.bottom)
            }
        }
    }
}
