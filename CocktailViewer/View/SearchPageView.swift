//
//  SearchPageView.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 9.09.2024.
//

import SwiftUI

struct SearchPageView: View {
    @EnvironmentObject var viewModel: CocktailViewModel
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("searchBarPlaceholder", text: $searchText)
                    .textInputAutocapitalization(.never)
                    .padding(.vertical, 10)
                    .padding(.leading, 20)
                    .padding(.trailing, 10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.leading)
                
                Button(action: {
                    Task {
                        await viewModel.fetchCocktailsByName(searchTerm: searchText)
                    }
                }) {
                    Image(systemName: "magnifyingglass")
                        .padding(10)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .padding(.trailing)
            }
            .padding(.top)
            
            List {
                ForEach(viewModel.searchedCocktails, id: \.id) { cocktail in
                    NavigationLink(value: SearchNavigation.cocktailDetail(id: cocktail.id)) {
                        HStack {
                            AsyncImage(url: URL(string: cocktail.imageUrl)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(8)
                                    .padding(.trailing)
                            } placeholder: {
                                ProgressView()
                            }
                            
                            Spacer()
                            
                            Text(cocktail.name)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                            
                            Text(cocktail.category)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                                .frame(maxWidth: 100, alignment: .leading)
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .applyGradientBackground()
        .navigationTitle("navTitleSearch")
        .onDisappear {
            searchText = ""
            viewModel.clearSearchedCocktails()
        }
    }
}

//#Preview {
//    SearchPageView()
//}
