//
//  NutritionUtils.swift
//  NutriSay Watch App
//
//  Created by Arya Adyatma on 19/05/24.
//

import Foundation
import HealthKit

public class NutritionUtils {
    
    static func logNutritionFactsToHealthKit(_ facts: Nutrition) {
        let healthStore = HKHealthStore()
        
        let nutritionTypes: [HKQuantityTypeIdentifier: Double] = [
            .dietaryEnergyConsumed: facts.energyConsumedKcal,
            .dietaryFatTotal: facts.fatTotalG,
            .dietaryFatPolyunsaturated: facts.fatPolyunsaturatedG,
            .dietaryFatMonounsaturated: facts.fatMonounsaturatedG,
            .dietaryFatSaturated: facts.fatSaturatedG,
            .dietaryCholesterol: facts.cholesterolMg,
            .dietarySodium: facts.sodiumMg,
            .dietaryCarbohydrates: facts.carbohydratesG,
            .dietaryFiber: facts.fiberG,
            .dietarySugar: facts.sugarG,
            .dietaryProtein: facts.proteinG,
            .dietaryVitaminA: facts.vitaminAUg,
            .dietaryVitaminB6: facts.vitaminB6Mg,
            .dietaryVitaminB12: facts.vitaminB12Ug,
            .dietaryVitaminC: facts.vitaminCMg,
            .dietaryVitaminD: facts.vitaminDUg,
            .dietaryVitaminE: facts.vitaminEMg,
            .dietaryVitaminK: facts.vitaminKUg,
            .dietaryCalcium: facts.calciumMg,
            .dietaryIron: facts.ironMg,
            .dietaryThiamin: facts.thiaminMg,
            .dietaryRiboflavin: facts.riboflavinMg,
            .dietaryNiacin: facts.niacinMg,
            .dietaryFolate: facts.folateUg,
            .dietaryBiotin: facts.biotinUg,
            .dietaryPantothenicAcid: facts.pantothenicAcidMg,
            .dietaryPhosphorus: facts.phosphorusMg,
            .dietaryIodine: facts.iodineUg,
            .dietaryMagnesium: facts.magnesiumMg,
            .dietaryZinc: facts.zincMg,
            .dietarySelenium: facts.seleniumUg,
            .dietaryCopper: facts.copperMg,
            .dietaryManganese: facts.manganeseMg,
            .dietaryChromium: facts.chromiumUg,
            .dietaryMolybdenum: facts.molybdenumUg,
            .dietaryChloride: facts.chlorideMg,
            .dietaryPotassium: facts.potassiumMg,
            .dietaryCaffeine: facts.caffeineMg,
            .dietaryWater: facts.waterL
        ]
        
        for (identifier, value) in nutritionTypes {
            guard value != 0, let quantityType = HKObjectType.quantityType(forIdentifier: identifier) else {
                continue
            }
            
            let unit: HKUnit
            switch identifier {
            case .dietaryEnergyConsumed:
                unit = .kilocalorie()
            case .dietaryWater:
                unit = .liter()
            default:
                unit = .gram()
            }
            
            let quantity = HKQuantity(unit: unit, doubleValue: value)
            let sample = HKQuantitySample(type: quantityType, quantity: quantity, start: Date(), end: Date())
            
            healthStore.save(sample) { success, error in
                if let error = error {
                    print("Error saving \(identifier.rawValue) to HealthKit: \(error.localizedDescription)")
                } else {
                    print("Successfully saved \(identifier.rawValue) to HealthKit")
                }
            }
        }
    }
    
}
