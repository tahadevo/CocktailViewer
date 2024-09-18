//
//  CocktailCardView.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 9.09.2024.
//

import SwiftUI

struct CocktailCardView: View {
    @State private var isLandscape: Bool = UIDevice.current.orientation.isLandscape
    
    var cocktail: Cocktail
    
    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: URL(string: cocktail.imageUrl)) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(height: isLandscape ? 100 : 150)
                    .cornerRadius(10.0)
            } placeholder: {
                ProgressView()
            }
            .padding(.bottom, 10)
            
            Text(cocktail.name)
                .font(.headline)
                .foregroundColor(Color("TextColor"))
            
            Text(cocktail.category)
                .font(.subheadline)
                .foregroundColor(Color("TextColor").opacity(0.8))
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("CardGradient1"), Color("CardGradient2")]), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(15.0)
        .frame(width: isLandscape ? 200 : 250, height: isLandscape ? 250 : 300)
        .onRotate { newOrientation in
            isLandscape = newOrientation.isLandscape
        }
    }
}
