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

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        if isAuthenticated {
            MainTabView(isAuthenticated: $isAuthenticated)
        } else {
            GeometryReader { geometry in
                VStack {
                    Text("welcomeMessage")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(colorScheme == .dark ? .yellow : .blue)
                        .padding(.bottom, 40)
                        .multilineTextAlignment(.center)

                    TextField("usernamePlaceholder", text: $username)
                        .padding()
                        .background(colorScheme == .dark ? Color(.systemGray5) : Color(.white))
                        .cornerRadius(10.0)
                        .padding(.horizontal)
                        .textInputAutocapitalization(.never)

                    SecureField("passwordPlaceholder", text: $password)
                        .padding()
                        .background(colorScheme == .dark ? Color(.systemGray5) : Color(.white))
                        .cornerRadius(10.0)
                        .padding(.horizontal)

                    Button(action: {
                        if username == "user" && password == "password" {
                            username = ""
                            password = ""
                            isAuthenticated = true
                        }
                    }) {
                        Text("loginButtonText")
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
                .background(
                    colorScheme == .dark ?
                    LinearGradient(gradient: Gradient(colors: [Color.black, Color.gray]), startPoint: .top, endPoint: .bottom) :
                    LinearGradient(gradient: Gradient(colors: [Color.pink.opacity(0.3), Color.white.opacity(0.8)]), startPoint: .top, endPoint: .bottom)
                )
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(CocktailViewModel())
}
