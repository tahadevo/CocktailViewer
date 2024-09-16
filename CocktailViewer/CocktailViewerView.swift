//
//  CocktailViewerView.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 6.09.2024.
//

import SwiftUI

struct MainPageView: View {
    @EnvironmentObject var viewModel: CocktailViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20.0) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.cocktails) { cocktail in
                                NavigationLink(destination: CocktailDetailView(id: cocktail.id)) {
                                    CocktailCardView(cocktail: cocktail)
                                }
                                .frame(width: 180)
                            }
                        }
                        .padding(.leading)
                    }
                    .padding(.vertical)
                    
                    Text("homepageTitleCategories")
                        .font(.headline)
                        .padding(.leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(viewModel.categories, id: \.self) { category in
                                NavigationLink(destination: FilteredCocktailsListView(filterType: .category, filterValue: category)) {
                                    VStack {
                                        Image(systemName: "cup.and.saucer.fill")
                                            .resizable()
                                            .frame(width: 40, height: 40)
                                            .foregroundColor(.white)
                                            .background(Circle().fill(Color.blue).frame(width: 60, height: 60))
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
                        HStack(spacing: 16) {
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
                                        .frame(width: 60, height: 60)
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
                    .padding(.bottom)
                    
                    Text("homepageTitleDiscover")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.purple)
                        .padding(.leading, 16)
                }
            }
            .navigationTitle("navTitleHome")
            .applyGradientBackground()
            .onAppear {
                Task {
                    await viewModel.initializeData()
                }
            }
        }
    }
}

#Preview {
    MainPageView()
        .environmentObject(CocktailViewModel())
}
