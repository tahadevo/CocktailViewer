//
//  CocktailViewerView.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 6.09.2024.
//

import SwiftUI

struct MainPageView: View {
    @EnvironmentObject var viewModel: CocktailViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.pink.opacity(0.3), Color.purple.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading, spacing: 20.0) {
                    Text("Discover Your Favorite Cocktails")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.leading, 16)
                    
                    Text("Browse through a wide selection of cocktails and find your new favorite.")
                        .font(.body)
                        .foregroundColor(.white.opacity(0.9))
                        .padding(.leading, 16)
                        .padding(.trailing, 16)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.cocktails) { cocktail in
                                NavigationLink(destination: CocktailDetailView(cocktail: cocktail)) {
                                    CocktailCardView(cocktail: cocktail, onAddToBasket: {
                                        viewModel.showAddToBasketOverlay(cocktail: cocktail)
                                    })
                                }
                                .frame(width: 250)
                            }
                        }
                        .padding(.leading)
                    }
                    .padding(.vertical)
                    
                    Text("Categories for You")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                    
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        HStack(spacing: 16) {
//                            ForEach(viewModel.categories, id: \.self) { category in
//                                CategoryView(category: category)
//                            }
//                        }
//                        .padding(.horizontal)
//                    }
                    
                    Spacer()
                }
                .navigationTitle("Explore")
            }
            .overlay(
                viewModel.showOverlay ? AddToBasketOverlayView(cocktail: viewModel.selectedCocktail!, onConfirm: {
                    viewModel.addToBasket(cocktail: viewModel.selectedCocktail!)
                }) : nil
            )
        }
    }
}

#Preview {
    MainPageView()
}
