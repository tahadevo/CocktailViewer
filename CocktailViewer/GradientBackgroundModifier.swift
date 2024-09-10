//
//  GradientBackgroundModifier.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 10.09.2024.
//

import SwiftUI

struct GradientBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.pink.opacity(0.3), Color.white.opacity(0.8)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
            )
    }
}

extension View {
    func applyGradientBackground() -> some View {
        self.modifier(GradientBackgroundModifier())
    }
}
