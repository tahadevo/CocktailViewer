//
//  MainTabView.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 9.09.2024.
//

import SwiftUI

struct MainTabView: View {
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
                
                UserPageView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
            }
            
            BadgeView(count: viewModel.basket.count)
                .offset(x: 55, y: 350)
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(CocktailViewModel())
}
