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
    
    init(mealName: String, nutrition: Nutrition, consumedDate: Date) {
        self.mealName = mealName
        self.nutrition = nutrition
        self.consumedDate = consumedDate
    }
    
    static func getSample() -> Meal {
        var sampleMeal = getEmpty()
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
            nutrition: Nutrition(
                energyConsumedKcal: 0,
                fatTotalG: 0,
                sodiumMg: 0,
                carbohydratesG: 0,
                fiberG: 0,
                sugarG: 0,
                proteinG: 0,
                vitaminAUg: 0,
                vitaminB6Mg: 0,
                vitaminB12Ug: 0,
                vitaminCMg: 0,
                vitaminDUg: 0,
                vitaminEMg: 0,
                vitaminKUg: 0,
                calciumMg: 0,
                ironMg: 0,
                thiaminMg: 0,
                riboflavinMg: 0,
                niacinMg: 0,
                folateUg: 0,
                biotinUg: 0,
                pantothenicAcidMg: 0,
                phosphorusMg: 0,
                iodineUg: 0,
                magnesiumMg: 0,
                zincMg: 0,
                seleniumUg: 0,
                copperMg: 0,
                manganeseMg: 0,
                chromiumUg: 0,
                molybdenumUg: 0,
                chlorideMg: 0,
                potassiumMg: 0,
                caffeineMg: 0,
                waterL: 0
            ),
            consumedDate: Date()
        )
    }
    
    func getDateString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMM yyyy\nHH:mm"
        return dateFormatter.string(from: self.consumedDate)
    }
    
}
