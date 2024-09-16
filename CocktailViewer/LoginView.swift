//
//  LoginView.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 9.09.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isAuthenticated = false

    var body: some View {
        if isAuthenticated {
            MainTabView(isAuthenticated: $isAuthenticated)
        } else {
            GeometryReader { geometry in
                VStack {
                    Text("Welcome to Cocktail Viewer")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                        .padding(.bottom, 40)
                        .multilineTextAlignment(.center)
                    
                    TextField("Username", text: $username)
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(10.0)
                        .padding(.horizontal)
                        .textInputAutocapitalization(.never)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.white))
                        .cornerRadius(10.0)
                        .padding(.horizontal)
                    
                    Button(action: {
                        if username == "user" && password == "password" {
                            username = ""
                            password = ""
                            isAuthenticated = true
                        }
                    }) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(10.0)
                            .padding(.horizontal)
                            .shadow(radius: 5)
                    }
                    .padding(.top, 20)
                }
                .padding()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .applyGradientBackground()
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(CocktailViewModel())
}
