//
//  MainMenu.swift
//  NutriSay Watch App
//
//  Created by Arya Adyatma on 16/05/24.
//

import SwiftUI
import SwiftData

struct MainMenuPage: View {
    
    @State var calorieProgress: CGFloat = 0.9 // Energy
    @State var proteinProgress: CGFloat = 0.5 // Protein
    @State var carbohydrateProgress: CGFloat = 0.30 // Carbs
    
    var targetEnergyKkal: Double = 1800
    var targetProteinG: Double = 90
    var targetCarbs: Double = 60
    
    @Query var meals: [Meal]
    
    @State var isPresentingModalView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 8) {
                    NutrientBar(progress: $calorieProgress, colorGradientStart: .yellow, colorGradientEnd: .yellow, icon: "bolt.fill", label: "CALORIES", currentValue: CGFloat(calorieProgress * targetEnergyKkal), targetValue: CGFloat(targetEnergyKkal), unit: "KCAL")
                    NutrientBar(progress: $proteinProgress, colorGradientStart: .blue, colorGradientEnd: .blue, icon: "dumbbell.fill", label: "PROTEIN", currentValue: CGFloat(proteinProgress * targetProteinG), targetValue: CGFloat(targetProteinG), unit: "G")
                    NutrientBar(progress: $carbohydrateProgress, colorGradientStart: .purple, colorGradientEnd: .purple, icon: "cube.fill", label: "CARBOHYDRATES", currentValue: CGFloat(carbohydrateProgress * targetCarbs), targetValue: CGFloat(targetCarbs), unit: "G")
                }
                .padding()
                
                Spacer()
                
                HStack {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.13))
                            .frame(width: 32, height: 32)
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(.white)
                    }
                    .onTapGesture {
                        isPresentingModalView.toggle()
                    }
                    
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
            .fullScreenCover(isPresented: $isPresentingModalView) {
                AddMealPage()
            }
        }
    }
}

struct NutrientBar: View {
    @Binding var progress: CGFloat
    var colorGradientStart: Color
    var colorGradientEnd: Color
    var icon: String
    var label: String
    var currentValue: CGFloat
    var targetValue: CGFloat
    var unit: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            HStack {
                Text(label)
                    .font(.system(size: 12))
                    .opacity(0.5)
                Spacer()
                Text("\(Int(currentValue)) / \(Int(targetValue))")
                    .foregroundStyle(colorGradientStart)
                    .font(.system(size: 12))
                    .offset(x: 3)
                Text(unit)
                    .foregroundStyle(colorGradientStart)
                    .font(.system(size: 10))
                    .offset(y: 1)
            }
            
            
            ZStack {
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(colorGradientStart.opacity(0.15))
                            .frame(height: 20)
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(
                                gradient: Gradient(colors: [colorGradientStart, colorGradientEnd]),
                                startPoint: .leading,
                                endPoint: .trailing
                            ))
                            .frame(width: min(geometry.size.width * progress, geometry.size.width), height: 20)
                    }
                    .frame(height: 20)
                    .padding(.leading, 5.5)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            ZStack {
                                Circle()
                                    .fill(colorGradientStart)
                                    .frame(width: 20, height: 20)
                                Image(systemName: icon)
                                    .foregroundColor(.black)
                                    .frame(width: 20, height: 20)
                                    .scaleEffect(0.75)
                            }
                        }
                        Spacer()
                    }
                }
                .frame(height: 20)
            }
        }
    }
}

#Preview {
    MainMenuPage()
}
