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
                        Text("homeTabText")
                    }
                
                SearchPageView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("searchTabText")
                    }
                
                BasketPageView()
                    .tabItem {
                        Image(systemName: "cart")
                        Text("basketTabText")
                    }
                    .badge(viewModel.basket.count)
                
                UserPageView(isAuthenticated: $isAuthenticated)
                    .tabItem {
                        Image(systemName: "person")
                        Text("profileTabText")
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
