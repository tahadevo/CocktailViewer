//
//  BadgeView.swift
//  CocktailViewer
//
//  Created by Taha Emir Gökçegöz on 11.09.2024.
//

import SwiftUI

struct BadgeView: View {
    var count: Int
    
    var body: some View {
        ZStack {
            if count > 0 {
                Text("\(count)")
                    .font(.caption2)
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.red)
                    .clipShape(Circle())
                    .offset(x: 10, y: -10)
            }
        }
    }
}
