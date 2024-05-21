//
//  MainMenu.swift
//  NutriSay Watch App
//
//  Created by Arya Adyatma on 16/05/24.
//

import SwiftUI
import SwiftData

struct MainMenuPage: View {
    
    @State var calorieProgress: CGFloat = 0.0 // Energy
    @State var proteinProgress: CGFloat = 0.5 // Protein
    @State var carbohydrateProgress: CGFloat = 0.0 // Carbs
    
    var targetEnergyKkal: Double = 1800
    var targetProteinG: Double = 90
    var targetCarbs: Double = 60
    
    @Query var meals: [Meal]
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 8) {
                    NutrientBar(progress: $calorieProgress, color: .yellow, icon: "bolt.fill", label: "CALORIES")
                    NutrientBar(progress: $proteinProgress, color: .blue, icon: "dumbbell.fill", label: "PROTEIN")
                    NutrientBar(progress: $carbohydrateProgress, color: .purple, icon: "cube.fill", label: "CARBOHYDRATES")
                }
                .padding()
                
                Spacer()
                
                HStack {
                    NavigationLink(destination: AddMealPage()) {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.13))
                                .frame(width: 32, height: 32)
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundColor(.white)
                        }
                    }
                    .buttonStyle(.plain)
                    
                    Spacer()
                    
                    NavigationLink(destination: MealHistoryPage()) {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.13))
                                .frame(width: 32, height: 32)
                            Image(systemName: "clock.arrow.circlepath")
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundColor(.white)
                        }
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal)
            }
            .onAppear {
                // Query today's meals then calculate the nutrition progress
                let todayMeals = meals.filter { Calendar.current.isDateInToday($0.consumedDate) }
                let totalNutrition = todayMeals.reduce(Nutrition()) { (result, meal) -> Nutrition in
                    var newResult = result
                    newResult.energyConsumedKcal += meal.nutrition.energyConsumedKcal
                    newResult.proteinG += meal.nutrition.proteinG
                    newResult.carbohydratesG += meal.nutrition.carbohydratesG
                    return newResult
                }
                
                calorieProgress = CGFloat(totalNutrition.energyConsumedKcal / targetEnergyKkal)
                proteinProgress = CGFloat(totalNutrition.proteinG / targetProteinG)
                carbohydrateProgress = CGFloat(totalNutrition.carbohydratesG / targetCarbs)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.green.opacity(0.15), Color.green.opacity(0.0)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
            )
        }
    }
}

struct NutrientBar: View {
    @Binding var progress: CGFloat
    var color: Color
    var icon: String
    var label: String = "PROTEIN"
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.caption2)
                .opacity(0.5)
                
            HStack {
                ZStack {
                    Circle()
                        .fill(color)
                        .frame(width: 20, height: 20)
                    Image(systemName: icon)
                        .foregroundColor(.black)
                        .frame(width: 20, height: 20)
                        .scaleEffect(0.8)
                }
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(color.opacity(0.2))
                            .frame(height: 20)
                        RoundedRectangle(cornerRadius: 10)
                            .fill(color)
                            .frame(width: geometry.size.width * progress, height: 20)
                    }
                }
                .frame(height: 20) // Ensure GeometryReader has a height constraint
                .offset(x: -15)
                .scaleEffect(x: 1.05)
            }
            .frame(height: 20)
        }
    }
}

#Preview {
    MainMenuPage()
}
