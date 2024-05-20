//
//  MainMenu.swift
//  NutriSay Watch App
//
//  Created by Arya Adyatma on 16/05/24.
//

import SwiftUI

struct MainMenuPage: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Text("NutriSAY!")
                    .font(.headline)
                    .foregroundStyle(.green)
                
                NavigationLink(destination: AddMealPage()) {
                    Text("Add Meal")
                }
                
                Button(action: {}) {
                    Text("My Nutrition")
                }
            }
        }
    }
}

#Preview {
    MainMenuPage()
}
