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
                    gradient: Gradient(colors: [Color("BackgroundGradient1"), Color("BackgroundGradient2")]),
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
