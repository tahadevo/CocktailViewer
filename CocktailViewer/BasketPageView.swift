//
//  BasketPageView.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 9.09.2024.
//

import SwiftUI

struct BasketPageView: View {
    @EnvironmentObject var viewModel: CocktailViewModel
    
    var body: some View {
        VStack {
            if viewModel.basket.count > 0 {
                List {
                    ForEach(viewModel.basket, id: \.id) { cocktail in
                        NavigationLink(value: BasketNavigation.cocktailDetail(id: cocktail.id)) {
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
                            }
                            .padding(.vertical, 8)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                
                Button(action: viewModel.saveCocktailsToSaved) {
                    Text("saveCocktailsButtonText")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10.0)
                }
                .buttonStyle(BorderlessButtonStyle())
                .padding()
            } else {
                Text("noItemsInBasketText")
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .applyGradientBackground()
        .navigationTitle("navTitleBasket")
    }
}
