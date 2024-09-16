//
//  UserPageView.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 9.09.2024.
//

import SwiftUI

struct UserPageView: View {
    @Binding var isAuthenticated: Bool
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    NavigationLink(destination: SavedCocktailsView()) {
                        Text("navTitleSavedCocktails")
                    }
                    
                    Button(action: {
                        isAuthenticated = false
                    }) {
                        Text("logoutText")
                            .foregroundColor(.red)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .applyGradientBackground()
            .navigationTitle("navTitleProfile")
        }
    }
}
