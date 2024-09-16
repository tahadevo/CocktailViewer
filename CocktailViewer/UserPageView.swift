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
                        Text("Saved Cocktails")
                    }
                    
                    Button(action: {
                        isAuthenticated = false
                    }) {
                        Text("Log Out")
                            .foregroundColor(.red)
                    }
                }
                .listStyle(PlainListStyle())
            }
            .applyGradientBackground()
            .navigationTitle("Profile")
        }
    }
}
