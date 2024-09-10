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
        NavigationView {
            VStack {
                HStack {
                    TextField("Search cocktails...", text: $searchText)
                        .textInputAutocapitalization(.never)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .onSubmit {
                            viewModel.fetchCocktails(searchTerm: searchText)
                        }
                }
                .padding(.top)
                
                List {
                    ForEach(viewModel.searchedCocktails, id: \.id) { cocktail in
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
                .listStyle(PlainListStyle())
            }
            .applyGradientBackground()
            .navigationTitle("Search")
        }
    }
}

#Preview {
    SearchPageView()
}
