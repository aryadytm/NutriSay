//
//  MainMenu.swift
//  NutriSay Watch App
//
//  Created by Arya Adyatma on 16/05/24.
//

import SwiftUI
import SwiftData

struct MainMenuPageRing: View {
    
    @State var bigRingrogress: CGFloat = 0.0 // Energy
    @State var mediumRingProgress: CGFloat = 0.0 // Protein
    @State var smallRingProgress: CGFloat = 0.0 // Carbs
    
    var targetEnergyKkal: Double = 1800
    var targetProteinG: Double = 90
    var targetCarbs: Double = 60
    
    @Query var meals: [Meal]
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    ActivityRings(
                        big: $bigRingrogress,
                        medium: $mediumRingProgress,
                        small: $smallRingProgress
                    )
                }
                .scaleEffect(0.92)
                .frame(width: 100, height: 100)
                .padding(.top, 20)
                
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
                
                bigRingrogress = CGFloat(totalNutrition.energyConsumedKcal / targetEnergyKkal)
                mediumRingProgress = CGFloat(totalNutrition.proteinG / targetProteinG)
                smallRingProgress = CGFloat(totalNutrition.carbohydratesG / targetCarbs)
            }
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.green.opacity(0.2), Color.green.opacity(0.0)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
            )
        }
    }
}

#Preview {
    MainMenuPageRing()
}

