//
//  GradientBackgroundModifier.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 10.09.2024.
//

import SwiftUI

struct GradientBackgroundModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    gradient: Gradient(colors: backgroundColors(for: colorScheme)),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
            )
    }
    
    private func backgroundColors(for colorScheme: ColorScheme) -> [Color] {
        switch colorScheme {
        case .light:
            return [Color.pink.opacity(0.3), Color.white.opacity(0.8)]
        case .dark:
            return [Color.black.opacity(0.8), Color.purple.opacity(0.4)]
        @unknown default:
            return [Color.pink.opacity(0.3), Color.white.opacity(0.8)]
        }
    }
}

extension View {
    func applyGradientBackground() -> some View {
        self.modifier(GradientBackgroundModifier())
    }
}
