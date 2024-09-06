//
//  CocktailViewerView.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 6.09.2024.
//

import SwiftUI

struct CocktailViewerView: View {
    @ObservedObject var viewModel = CocktailViewModel()
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search cocktails", text: $searchText, onCommit: {
                    viewModel.fetchCocktails(searchTerm: searchText)
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                List(viewModel.cocktails) { cocktail in
                    VStack(alignment: .leading) {
                        Text(cocktail.name)
                            .font(.headline)
                        Text(cocktail.category)
                            .font(.subheadline)
                        Text(cocktail.instructions)
                            .font(.body)
                            .lineLimit(2)
                        AsyncImage(url: URL(string: cocktail.imageUrl)) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(height: 100)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
            .navigationTitle("Cocktail Viewer")
        }
    }
}

struct ContentView: View {
    var body: some View {
        CocktailViewerView()
    }
}

#Preview {
    ContentView()
}
