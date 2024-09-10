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
        NavigationView {
            VStack {
                ForEach(viewModel.basket) { cocktail in
                    Text(cocktail.name)
                }
                
                Button(action: viewModel.saveCocktailsToSaved) {
                    Text("Save Cocktails in Basket")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10.0)
                }
                .buttonStyle(BorderlessButtonStyle())
                .padding()
            }
            .navigationTitle("Basket")
            .applyGradientBackground()
        }
    }
}
