//
//  CocktailDetailView.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 9.09.2024.
//

import SwiftUI

struct CocktailDetailView: View {
    @EnvironmentObject var viewModel: CocktailViewModel
    var cocktail: Cocktail
    
    var body: some View {
        VStack(spacing: 16) {
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
            
            Text(cocktail.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text("Category: \(cocktail.category)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Divider()
            
            Text("Ingredients and Instructions")
                .font(.headline)
                .padding(.top)
            
            Text("This section could include the cocktail's ingredients and preparation instructions.")
            
            Spacer()
            
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
        .navigationBarTitle(cocktail.name, displayMode: .inline)
    }
}
