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
    
    @State private var selectedTab: Tab = .home
    
    @State private var homeNavigationPath: [HomeNavigation] = []
    @State private var searchNavigationPath: [SearchNavigation] = []
    @State private var basketNavigationPath: [BasketNavigation] = []
    @State private var profileNavigationPath: [ProfileNavigation] = []

    var body: some View {
        TabView(selection: tabSelection()) {
            NavigationStack(path: $homeNavigationPath) {
                MainPageView()
                    .navigationDestination(for: HomeNavigation.self) { destination in
                        switch destination {
                        case .cocktailDetail(let id):
                            CocktailDetailView(id: id)
                        case .category(let selectedCategory):
                            FilteredCocktailsListView(filterType: .category, filterValue: selectedCategory)
                        case .ingredient(let selectedIngredient):
                            FilteredCocktailsListView(filterType: .ingredient, filterValue: selectedIngredient)
                        }
                    }
            }
            .tabItem {
                Image(systemName: "house")
                Text("homeTabText")
            }
            .tag(Tab.home)
            
            NavigationStack(path: $searchNavigationPath) {
                SearchPageView()
                    .navigationDestination(for: SearchNavigation.self) { destination in
                        switch destination {
                        case .cocktailDetail(let id):
                            CocktailDetailView(id: id)
                        }
                    }
            }
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("searchTabText")
            }
            .tag(Tab.search)
            
            NavigationStack(path: $basketNavigationPath) {
                BasketPageView()
                    .navigationDestination(for: BasketNavigation.self) { destination in
                        switch destination {
                        case .cocktailDetail(let id):
                            CocktailDetailView(id: id)
                        }
                    }
            }
            .tabItem {
                Image(systemName: "cart")
                Text("basketTabText")
            }
            .badge(viewModel.basket.count)
            .tag(Tab.basket)
            
            NavigationStack(path: $profileNavigationPath) {
                UserPageView(isAuthenticated: $isAuthenticated)
                    .navigationDestination(for: ProfileNavigation.self) { destination in
                        switch destination {
                        case .savedCocktails:
                            SavedCocktailsView()
                        case .cocktailDetail(let id):
                            CocktailDetailView(id: id)
                        }
                    }
            }
            .tabItem {
                Image(systemName: "person")
                Text("profileTabText")
            }
            .tag(Tab.profile)
        }
    }
}

extension MainTabView {
    private func tabSelection() -> Binding<Tab> {
        Binding {
            self.selectedTab
        } set: { tappedTab in
            switch self.selectedTab {
            case .home:
                homeNavigationPath = []
            case .search:
                searchNavigationPath = []
            case.basket:
                basketNavigationPath = []
            case .profile:
                profileNavigationPath = []
            }
            
            self.selectedTab = tappedTab
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
