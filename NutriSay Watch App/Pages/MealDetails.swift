import SwiftUI

struct MealDetails: View {
    // TODO: This should be Meal model based on SwiftData.
    var mealName: String
    var nutritionFacts: NutritionFacts
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 4) {
                Text(mealName)
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
                
                Text("Sunday, 19 May 2024\n13:38")
                    .font(.caption)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .opacity(0.50)
                
                
                Text("MAIN NUTRIENTS")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.green)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
                    .padding(.top)
                
//                Text("MAIN NUTRIENTS")
//                    .fontWeight(.semibold)
//                    .foregroundColor(Color.white)
//                    .multilineTextAlignment(.leading)
//                    .lineLimit(5)
//                    .padding(.top)
//                    .opacity(0.5)
                
                NutritionRow(label: "Calories", value: nutritionFacts.energyConsumedKcal, unit: "kcal")
                NutritionRow(label: "Carbohydrates", value: nutritionFacts.carbohydratesG, unit: "g")
                NutritionRow(label: "Protein", value: nutritionFacts.proteinG, unit: "g")
                NutritionRow(label: "Fat (Total)", value: nutritionFacts.fatTotalG, unit: "g")
                
                Text("DETAILED NUTRIENTS")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.green)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
                    .padding(.top)
                
                if nutritionFacts.fatPolyunsaturatedG != 0 {
                    NutritionRow(label: "Polyunsaturated Fat", value: nutritionFacts.fatPolyunsaturatedG, unit: "g")
                }
                if nutritionFacts.fatMonounsaturatedG != 0 {
                    NutritionRow(label: "Monounsaturated Fat", value: nutritionFacts.fatMonounsaturatedG, unit: "g")
                }
                if nutritionFacts.fatSaturatedG != 0 {
                    NutritionRow(label: "Saturated Fat", value: nutritionFacts.fatSaturatedG, unit: "g")
                }
                if nutritionFacts.cholesterolMg != 0 {
                    NutritionRow(label: "Cholesterol", value: nutritionFacts.cholesterolMg, unit: "mg")
                }
                if nutritionFacts.sodiumMg != 0 {
                    NutritionRow(label: "Sodium", value: nutritionFacts.sodiumMg, unit: "mg")
                }

                if nutritionFacts.fiberG != 0 {
                    NutritionRow(label: "Fiber", value: nutritionFacts.fiberG, unit: "g")
                }
                if nutritionFacts.sugarG != 0 {
                    NutritionRow(label: "Sugar", value: nutritionFacts.sugarG, unit: "g")
                }

                if nutritionFacts.vitaminAUg != 0 {
                    NutritionRow(label: "Vitamin A", value: nutritionFacts.vitaminAUg, unit: "µg")
                }
                if nutritionFacts.vitaminB6Mg != 0 {
                    NutritionRow(label: "Vitamin B6", value: nutritionFacts.vitaminB6Mg, unit: "mg")
                }
                if nutritionFacts.vitaminB12Ug != 0 {
                    NutritionRow(label: "Vitamin B12", value: nutritionFacts.vitaminB12Ug, unit: "µg")
                }
                if nutritionFacts.vitaminCMg != 0 {
                    NutritionRow(label: "Vitamin C", value: nutritionFacts.vitaminCMg, unit: "mg")
                }
                if nutritionFacts.vitaminDUg != 0 {
                    NutritionRow(label: "Vitamin D", value: nutritionFacts.vitaminDUg, unit: "µg")
                }
                if nutritionFacts.vitaminEMg != 0 {
                    NutritionRow(label: "Vitamin E", value: nutritionFacts.vitaminEMg, unit: "mg")
                }
                if nutritionFacts.vitaminKUg != 0 {
                    NutritionRow(label: "Vitamin K", value: nutritionFacts.vitaminKUg, unit: "µg")
                }
                if nutritionFacts.calciumMg != 0 {
                    NutritionRow(label: "Calcium", value: nutritionFacts.calciumMg, unit: "mg")
                }
                if nutritionFacts.ironMg != 0 {
                    NutritionRow(label: "Iron", value: nutritionFacts.ironMg, unit: "mg")
                }
                if nutritionFacts.thiaminMg != 0 {
                    NutritionRow(label: "Thiamin", value: nutritionFacts.thiaminMg, unit: "mg")
                }
                if nutritionFacts.riboflavinMg != 0 {
                    NutritionRow(label: "Riboflavin", value: nutritionFacts.riboflavinMg, unit: "mg")
                }
                if nutritionFacts.niacinMg != 0 {
                    NutritionRow(label: "Niacin", value: nutritionFacts.niacinMg, unit: "mg")
                }
                if nutritionFacts.folateUg != 0 {
                    NutritionRow(label: "Folate", value: nutritionFacts.folateUg, unit: "µg")
                }
                if nutritionFacts.biotinUg != 0 {
                    NutritionRow(label: "Biotin", value: nutritionFacts.biotinUg, unit: "µg")
                }
                if nutritionFacts.pantothenicAcidMg != 0 {
                    NutritionRow(label: "Pantothenic Acid", value: nutritionFacts.pantothenicAcidMg, unit: "mg")
                }
                if nutritionFacts.phosphorusMg != 0 {
                    NutritionRow(label: "Phosphorus", value: nutritionFacts.phosphorusMg, unit: "mg")
                }
                if nutritionFacts.iodineUg != 0 {
                    NutritionRow(label: "Iodine", value: nutritionFacts.iodineUg, unit: "µg")
                }
                if nutritionFacts.magnesiumMg != 0 {
                    NutritionRow(label: "Magnesium", value: nutritionFacts.magnesiumMg, unit: "mg")
                }
                if nutritionFacts.zincMg != 0 {
                    NutritionRow(label: "Zinc", value: nutritionFacts.zincMg, unit: "mg")
                }
                if nutritionFacts.seleniumUg != 0 {
                    NutritionRow(label: "Selenium", value: nutritionFacts.seleniumUg, unit: "µg")
                }
                if nutritionFacts.copperMg != 0 {
                    NutritionRow(label: "Copper", value: nutritionFacts.copperMg, unit: "mg")
                }
                if nutritionFacts.manganeseMg != 0 {
                    NutritionRow(label: "Manganese", value: nutritionFacts.manganeseMg, unit: "mg")
                }
                if nutritionFacts.chromiumUg != 0 {
                    NutritionRow(label: "Chromium", value: nutritionFacts.chromiumUg, unit: "µg")
                }
                if nutritionFacts.molybdenumUg != 0 {
                    NutritionRow(label: "Molybdenum", value: nutritionFacts.molybdenumUg, unit: "µg")
                }
                if nutritionFacts.chlorideMg != 0 {
                    NutritionRow(label: "Chloride", value: nutritionFacts.chlorideMg, unit: "mg")
                }
                if nutritionFacts.potassiumMg != 0 {
                    NutritionRow(label: "Potassium", value: nutritionFacts.potassiumMg, unit: "mg")
                }
                if nutritionFacts.caffeineMg != 0 {
                    NutritionRow(label: "Caffeine", value: nutritionFacts.caffeineMg, unit: "mg")
                }
                if nutritionFacts.waterL != 0 {
                    NutritionRow(label: "Water", value: nutritionFacts.waterL, unit: "L")
                }
                
                Spacer()
            }
            .padding()
        .navigationTitle("Meal Details")
        }
    }
}

struct NutritionRow: View {
    var label: String
    var value: Double
    var unit: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.caption)
            Spacer()
            Text("\(value, specifier: "%.0f") \(unit)")
                .font(.caption)
        }
    }
}

struct MealDetails_Previews: PreviewProvider {
    static var previews: some View {
        MealDetails(
            mealName: "Fried Chicken (Breast), One Piece",
            nutritionFacts: NutritionFacts(
                energyConsumedKcal: 250,
                fatTotalG: 15,
                sodiumMg: 500, 
                carbohydratesG: 0,
                fiberG: 0, 
                sugarG: 0, 
                proteinG: 26,
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
            )
        )
    }
}

