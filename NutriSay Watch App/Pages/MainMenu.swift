//
//  MainMenu.swift
//  NutriSay Watch App
//
//  Created by Arya Adyatma on 16/05/24.
//

import SwiftUI

struct MainMenu: View {
    
    var body: some View {
        NavigationView {
            VStack {
                Text("NutriSAY!")
                
                NavigationLink(destination: AddMeal()) {
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
    MainMenu()
}
