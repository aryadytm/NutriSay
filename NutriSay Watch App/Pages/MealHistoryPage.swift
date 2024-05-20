//
//  NutritionListPage.swift
//  NutriSay Watch App
//
//  Created by Arya Adyatma on 20/05/24.
//

import SwiftUI
import SwiftData

struct MealHistoryPage: View {
    var meals: [Meal] = [
        Meal.getSample(),
        Meal.getSample(),
        Meal.getSample(),
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Today")
                ForEach(meals) { meal in
                    MealItem(meal: meal)
                }
                
                Text("Yesterday")
                    .padding(.top, 16)
                ForEach(meals) { meal in
                    MealItem(meal: meal)
                }
            }
        }
    }
}

struct MealItem: View {
    var meal: Meal
    
    var body: some View {
        let energyConsumed = Nutrition
            .getFormattedUnit(value: meal.nutrition.energyConsumedKcal, unit: "")
            .split(separator: ".")[0]
        let protein = Nutrition
            .getFormattedUnit(value: meal.nutrition.proteinG, unit: "")
            .split(separator: ".")[0]
        let carbohydrates = Nutrition
            .getFormattedUnit(value: meal.nutrition.carbohydratesG, unit: "")
            .split(separator: ".")[0]
        
        return VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: "square.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundStyle(.orange)
 
                VStack(alignment: .leading) {
                    HStack {
                        Text(meal.mealName)
                            .font(.caption)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    Text(meal.getDateString().split(separator: "\n")[1])
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.leading, 4)
            }
            
            HStack {
                Image(systemName: "square.fill")
                    .foregroundStyle(.blue)
                Text("\(energyConsumed)")
                    .font(.caption2)
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: "square.fill")
                    .foregroundStyle(.blue)
                Text("\(protein)")
                    .font(.caption2)
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: "square.fill")
                    .foregroundStyle(.blue)
                Text("\(carbohydrates)")
                    .font(.caption2)
                    .foregroundColor(.primary)

            }

        }
        .padding()
        .background(Color(.white).opacity(0.1))
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}
#Preview {
    MealHistoryPage()
}
