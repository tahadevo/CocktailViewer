//
//  OnRotateModifier.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 16.09.2024.
//

import SwiftUI
import Combine

struct OnRotateModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(OnRotateModifier(action: action))
    }
}
