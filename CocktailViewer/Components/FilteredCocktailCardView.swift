//
//  CocktailCardView.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 9.09.2024.
//

import SwiftUI

struct FilteredCocktailCardView: View {
    var cocktail: FilteredCocktail
    
    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: URL(string: cocktail.imageUrl)) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(height: 75)
                    .cornerRadius(10.0)
            } placeholder: {
                ProgressView()
            }
            .padding(.bottom, 10)
            
            Text(cocktail.name)
                .font(.headline)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .frame(width: 75)
                .foregroundColor(Color("TextColor"))
        }
        .padding()
        .frame(maxHeight: .infinity, alignment: .top)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("CardGradient1"), Color("CardGradient2")]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(15.0)
    }
}
