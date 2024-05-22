//
//  Meal.swift
//  NutriSay Watch App
//
//  Created by Arya Adyatma on 20/05/24.
//
import Foundation
import SwiftData

@Model
final class Meal {
    var id: String = UUID().uuidString
    var mealName: String
    var nutrition: Nutrition
    var consumedDate: Date
    var emoji: String = "🍴"
    
    init(mealName: String, nutrition: Nutrition, consumedDate: Date) {
        self.mealName = mealName
        self.nutrition = nutrition
        self.consumedDate = consumedDate
//        self.emoji = nutrition.emoji
    }
    
    static func getSample() -> Meal {
        let sampleMeal = getEmpty()
        sampleMeal.mealName = "Sample Meal"
        sampleMeal.nutrition.energyConsumedKcal = Double.random(in: 50...250)
        sampleMeal.nutrition.proteinG = Double.random(in: 10...50)
        sampleMeal.nutrition.carbohydratesG = Double.random(in: 10...50)
        sampleMeal.nutrition.fatTotalG = Double.random(in: 10...50)
        return sampleMeal
    }
    
    static func getEmpty() -> Meal {
        return Meal(
            mealName: "Empty Meal",
            nutrition: Nutrition(),
            consumedDate: Date()
        )
    }
    
    func getDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMM yyyy\nHH:mm"
        return dateFormatter.string(from: self.consumedDate)
    }
    
}
