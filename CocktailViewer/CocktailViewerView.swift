//
//  CocktailViewerView.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 6.09.2024.
//

import SwiftUI

struct MainPageView: View {
    @EnvironmentObject var viewModel: CocktailViewModel
    @State private var isLandscape: Bool = UIDevice.current.orientation.isLandscape
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: isLandscape ? 7.5 : 20.0) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: isLandscape ? 8 : 16) {
                        ForEach(viewModel.cocktails) { cocktail in
                            NavigationLink(value: HomeNavigation.cocktailDetail(id: cocktail.id)) {
                                CocktailCardView(cocktail: cocktail)
                            }
                            .frame(width: isLandscape ? 135 : 180)
                        }
                    }
                    .padding(.leading)
                }
                .padding(.vertical, isLandscape ? 5 : 10)
                
                Text("homepageTitleDiscover")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.purple)
                    .padding(.leading, 16)
                
                Text("homepageTitleCategories")
                    .font(.headline)
                    .padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: isLandscape ? 8 : 16) {
                        ForEach(viewModel.categories, id: \.self) { category in
                            NavigationLink(value: HomeNavigation.category(category)) {
                                VStack {
                                    Image(systemName: "cup.and.saucer.fill")
                                        .resizable()
                                        .frame(width: isLandscape ? 25 : 40, height: isLandscape ? 25 : 40)
                                        .foregroundColor(.white)
                                        .background(Circle().fill(Color.blue).frame(width: isLandscape ? 40 : 60, height: isLandscape ? 40 : 60))
                                        .padding()

                                    Text(category)
                                        .font(.caption)
                                        .foregroundColor(.primary)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
                
                Text("homepageTitleIngredients")
                    .font(.headline)
                    .padding(.leading)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: isLandscape ? 8 : 16) {
                        ForEach(viewModel.ingredients, id: \.self) { ingredient in
                            NavigationLink(destination: FilteredCocktailsListView(filterType: .ingredient, filterValue: ingredient)) {
                                VStack {
                                    AsyncImage(url: URL(string: "https://www.thecocktaildb.com/images/ingredients/\(ingredient)-Small.png")) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                    } placeholder: {
                                        Color.gray
                                    }
                                    .frame(width: isLandscape ? 40 : 60, height: isLandscape ? 40 : 60)
                                    .clipShape(Circle())
                                    
                                    Text(ingredient)
                                        .font(.caption)
                                        .foregroundColor(.primary)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, isLandscape ? 5 : 10)
            }
        }
        .navigationTitle("navTitleHome")
        .applyGradientBackground()
        .onRotate { newOrientation in
            isLandscape = newOrientation.isLandscape
        }
        .onAppear {
            Task {
                await viewModel.initializeData()
            }
        }
    }
}

//#Preview {
//    MainPageView()
//        .environmentObject(CocktailViewModel())
//}
