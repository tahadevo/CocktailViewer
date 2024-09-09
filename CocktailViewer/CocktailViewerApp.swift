//
//  CocktailViewerApp.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 6.09.2024.
//

import SwiftUI

@main
struct CocktailViewerApp: App {
    @StateObject var viewModel = CocktailViewModel()
    
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environmentObject(viewModel)
        }
    }
}
