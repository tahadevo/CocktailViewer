//
//  UserPageView.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 9.09.2024.
//

import SwiftUI

struct UserPageView: View {
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    NavigationLink(destination: SavedCocktailsView()) {
                        Text("Saved Cocktails")
                    }
                    
                    Button("Log Out") {
                        //handle
                    }
                }
                .listStyle(PlainListStyle())
            }
            .applyGradientBackground()
            .navigationTitle("Profile")
        }
    }
}
