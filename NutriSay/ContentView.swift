//
//  ContentView.swift
//  NutriSay
//
//  Created by Arya Adyatma on 15/05/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image("applogo")
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(16)
                .padding()
            Text("Please open NutriSAY! in your watchOS device.")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
