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
            MainTabView()
        } else {
            VStack {
                Text("Welcome to Cocktail Viewer")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                    .padding(.bottom, 40)
                    .multilineTextAlignment(.center)
                
                TextField("Username", text: $username)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10.0)
                    .padding(.horizontal)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10.0)
                    .padding(.horizontal)
                
                Button(action: {
                    if username == "user" && password == "password" {
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
            .background(Color(.systemBackground))
        }
    }
}

#Preview {
    LoginView()
}
