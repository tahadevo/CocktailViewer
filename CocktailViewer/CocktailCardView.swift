//
//  CocktailCardView.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 9.09.2024.
//

import SwiftUI

struct CocktailCardView: View {
    var cocktail: Cocktail
    var onAddToBasket: () -> Void
    
    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: URL(string: cocktail.imageUrl)) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(height: 150)
                    .cornerRadius(10.0)
            } placeholder: {
                ProgressView()
            }
            .padding(.bottom, 10)
            
            Text(cocktail.name)
                .font(.headline)
                .foregroundColor(.purple)
            
            Text(cocktail.category)
                .font(.subheadline)
                .foregroundColor(.purple.opacity(0.8))
            
            Spacer()
            
            Button(action: onAddToBasket) {
                Text("Add to Basket")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10.0)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.white.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(15.0)
        .frame(width: 250, height: 300)
    }
}

struct AddToBasketOverlayView: View {
    var cocktail: Cocktail
    var onConfirm: () -> Void
    
    var body: some View {
        VStack {
            Text("Add \(cocktail.name) to Basket?")
                .font(.headline)
                .padding()
            
            HStack {
                Button("Cancel") {
                    
                }
                .padding()
                
                Button("Add") {
                    onConfirm()
                }
                .padding()
            }
        }
        .background(Color.white)
        .cornerRadius(10.0)
        .shadow(radius: 10.0)
    }
}
