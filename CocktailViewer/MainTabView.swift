//
//  MainTabView.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 9.09.2024.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            MainPageView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            
            SearchPageView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            BasketPageView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Basket")
                }
            
            UserPageView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(CocktailViewModel())
}
