//
//  GradientPage.swift
//  NutriSay Watch App
//
//  Created by Arya Adyatma on 21/05/24.
//

import SwiftUI

struct GradientPage: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(" ")
                Spacer()
            }
            Spacer()
            Text(" ")
            Spacer()
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.green.opacity(0.3), Color.green.opacity(0.0)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
        )
    }
}

#Preview {
    GradientPage()
}
