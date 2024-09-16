//
//  MainTabView.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 9.09.2024.
//

import SwiftUI

struct MainTabView: View {
    @Binding var isAuthenticated: Bool
    @EnvironmentObject var viewModel: CocktailViewModel
    
    var body: some View {
        ZStack {
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
                    .badge(viewModel.basket.count)
                
                UserPageView(isAuthenticated: $isAuthenticated)
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
            }
        }
    }
}

#Preview {
    struct Preview: View {
        @State var isAuthenticated = true
        var body: some View {
            MainTabView(isAuthenticated: $isAuthenticated)
                .environmentObject(CocktailViewModel())
        }
    }
    
    return Preview()
}
