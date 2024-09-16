//
//  CocktailCardView.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 9.09.2024.
//

import SwiftUI

struct CocktailCardView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var cocktail: Cocktail
    
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
                .foregroundColor(textColor(for: colorScheme))
            
            Text(cocktail.category)
                .font(.subheadline)
                .foregroundColor(textColor(for: colorScheme).opacity(0.8))
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: cardBackgroundColors(for: colorScheme)), startPoint: .top, endPoint: .bottom)
        )
        .cornerRadius(15.0)
        .frame(width: 250, height: 300)
    }
    
    private func cardBackgroundColors(for colorScheme: ColorScheme) -> [Color] {
        switch colorScheme {
        case .light:
            return [Color.blue.opacity(0.3), Color.white.opacity(0.8)]
        case .dark:
            return [Color.pink.opacity(0.4), Color.red.opacity(0.4)]
        @unknown default:
            return [Color.blue.opacity(0.3), Color.white.opacity(0.8)]
        }
    }
    
    private func textColor(for colorScheme: ColorScheme) -> Color {
        colorScheme == .dark ? Color.white : Color.purple
    }
}
