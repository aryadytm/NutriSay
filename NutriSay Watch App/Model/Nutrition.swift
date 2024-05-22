//
//  NutritionFacts.swift
//  NutriSay Watch App
//
//  Created by Arya Adyatma on 19/05/24.
//

import Foundation
import Yams

struct Nutrition : Codable {
    var energyConsumedKcal: Double = 0
    var fatTotalG: Double = 0
    var fatPolyunsaturatedG: Double = 0
    var fatMonounsaturatedG: Double = 0
    var fatSaturatedG: Double = 0
    var cholesterolMg: Double = 0
    var sodiumMg: Double = 0
    var carbohydratesG: Double = 0
    var fiberG: Double = 0
    var sugarG: Double = 0
    var proteinG: Double = 0
    var vitaminAUg: Double = 0
    var vitaminB6Mg: Double = 0
    var vitaminB12Ug: Double = 0
    var vitaminCMg: Double = 0
    var vitaminDUg: Double = 0
    var vitaminEMg: Double = 0
    var vitaminKUg: Double = 0
    var calciumMg: Double = 0
    var ironMg: Double = 0
    var thiaminMg: Double = 0
    var riboflavinMg: Double = 0
    var niacinMg: Double = 0
    var folateUg: Double = 0
    var biotinUg: Double = 0
    var pantothenicAcidMg: Double = 0
    var phosphorusMg: Double = 0
    var iodineUg: Double = 0
    var magnesiumMg: Double = 0
    var zincMg: Double = 0
    var seleniumUg: Double = 0
    var copperMg: Double = 0
    var manganeseMg: Double = 0
    var chromiumUg: Double = 0
    var molybdenumUg: Double = 0
    var chlorideMg: Double = 0
    var potassiumMg: Double = 0
    var caffeineMg: Double = 0
    var waterL: Double = 0
    
    static func getFormattedUnit(value: Double, unit: String) -> String {
        return value == floor(value) ? "\(Int(value)) \(unit)" : String(format: "%.1f \(unit)", value)
    }
    
    static func fromYamlString(yamlString: String, meal: Meal) -> Nutrition? {
        guard let yaml = try? Yams.load(yaml: yamlString) as? [String: Any] else {
            return nil
        }
                
        print(yamlString)
        
        var facts = Nutrition()
        
        facts.energyConsumedKcal = Double("\(yaml["energyConsumedKcal"] ?? 0)") ?? 0
        facts.fatTotalG = Double("\(yaml["fatTotalG"] ?? 0)") ?? 0
        facts.fatPolyunsaturatedG = Double("\(yaml["fatPolyunsaturatedG"] ?? 0)") ?? 0
        facts.fatMonounsaturatedG = Double("\(yaml["fatMonounsaturatedG"] ?? 0)") ?? 0
        facts.fatSaturatedG = Double("\(yaml["fatSaturatedG"] ?? 0)") ?? 0
        facts.cholesterolMg = Double("\(yaml["cholesterolMg"] ?? 0)") ?? 0
        facts.sodiumMg = Double("\(yaml["sodiumMg"] ?? 0)") ?? 0
        facts.carbohydratesG = Double("\(yaml["carbohydratesG"] ?? 0)") ?? 0
        facts.fiberG = Double("\(yaml["fiberG"] ?? 0)") ?? 0
        facts.sugarG = Double("\(yaml["sugarG"] ?? 0)") ?? 0
        facts.proteinG = Double("\(yaml["proteinG"] ?? 0)") ?? 0
        facts.vitaminAUg = Double("\(yaml["vitaminAUg"] ?? 0)") ?? 0
        facts.vitaminB6Mg = Double("\(yaml["vitaminB6Mg"] ?? 0)") ?? 0
        facts.vitaminB12Ug = Double("\(yaml["vitaminB12Ug"] ?? 0)") ?? 0
        facts.vitaminCMg = Double("\(yaml["vitaminCMg"] ?? 0)") ?? 0
        facts.vitaminDUg = Double("\(yaml["vitaminDUg"] ?? 0)") ?? 0
        facts.vitaminEMg = Double("\(yaml["vitaminEMg"] ?? 0)") ?? 0
        facts.vitaminKUg = Double("\(yaml["vitaminKUg"] ?? 0)") ?? 0
        facts.calciumMg = Double("\(yaml["calciumMg"] ?? 0)") ?? 0
        facts.ironMg = Double("\(yaml["ironMg"] ?? 0)") ?? 0
        facts.thiaminMg = Double("\(yaml["thiaminMg"] ?? 0)") ?? 0
        facts.riboflavinMg = Double("\(yaml["riboflavinMg"] ?? 0)") ?? 0
        facts.niacinMg = Double("\(yaml["niacinMg"] ?? 0)") ?? 0
        facts.folateUg = Double("\(yaml["folateUg"] ?? 0)") ?? 0
        facts.biotinUg = Double("\(yaml["biotinUg"] ?? 0)") ?? 0
        facts.pantothenicAcidMg = Double("\(yaml["pantothenicAcidMg"] ?? 0)") ?? 0
        facts.phosphorusMg = Double("\(yaml["phosphorusMg"] ?? 0)") ?? 0
        facts.iodineUg = Double("\(yaml["iodineUg"] ?? 0)") ?? 0
        facts.magnesiumMg = Double("\(yaml["magnesiumMg"] ?? 0)") ?? 0
        facts.zincMg = Double("\(yaml["zincMg"] ?? 0)") ?? 0
        facts.seleniumUg = Double("\(yaml["seleniumUg"] ?? 0)") ?? 0
        facts.copperMg = Double("\(yaml["copperMg"] ?? 0)") ?? 0
        facts.manganeseMg = Double("\(yaml["manganeseMg"] ?? 0)") ?? 0
        facts.chromiumUg = Double("\(yaml["chromiumUg"] ?? 0)") ?? 0
        facts.molybdenumUg = Double("\(yaml["molybdenumUg"] ?? 0)") ?? 0
        facts.chlorideMg = Double("\(yaml["chlorideMg"] ?? 0)") ?? 0
        facts.potassiumMg = Double("\(yaml["potassiumMg"] ?? 0)") ?? 0
        facts.caffeineMg = Double("\(yaml["caffeineMg"] ?? 0)") ?? 0
        facts.waterL = Double("\(yaml["waterL"] ?? 0)") ?? 0
        
        let emoji = yaml["emoji"] as? String ?? "🍴"
        meal.emoji = emoji
        
        return facts
    }
}

