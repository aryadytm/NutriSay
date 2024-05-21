import SwiftUI
import SwiftData

struct MealDetailsPage: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var meal: Meal
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 4) {
                Text(meal.mealName)
                    .font(.headline)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
                
                Text(meal.getDateString())
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
                
                NutritionRowWithImage(
                    label: "Calories",
                    value: meal.nutrition.energyConsumedKcal,
                    unit: "kcal",
                    image: "bolt.fill",
                    imageColor: .yellow
                )
                
                NutritionRowWithImage(
                    label: "Protein",
                    value: meal.nutrition.proteinG,
                    unit: "g",
                    image: "dumbbell.fill",
                    imageColor: .blue
                )
                
                NutritionRowWithImage(
                    label: "Carbohydrates",
                    value: meal.nutrition.carbohydratesG,
                    unit: "g",
                    image: "cube.fill",
                    imageColor: .purple
                )

                NutritionRowWithImage(
                    label: "Fat (Total)",
                    value: meal.nutrition.fatTotalG,
                    unit: "g",
                    image: "drop.halffull",
                    imageColor: .orange
                )

                Text("DETAILED NUTRIENTS")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.green)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
                    .padding(.top)
                
                if meal.nutrition.fatPolyunsaturatedG != 0 {
                    NutritionRow(label: "Polyunsaturated Fat", value: meal.nutrition.fatPolyunsaturatedG, unit: "g")
                }
                if meal.nutrition.fatMonounsaturatedG != 0 {
                    NutritionRow(label: "Monounsaturated Fat", value: meal.nutrition.fatMonounsaturatedG, unit: "g")
                }
                if meal.nutrition.fatSaturatedG != 0 {
                    NutritionRow(label: "Saturated Fat", value: meal.nutrition.fatSaturatedG, unit: "g")
                }
                if meal.nutrition.cholesterolMg != 0 {
                    NutritionRow(label: "Cholesterol", value: meal.nutrition.cholesterolMg, unit: "mg")
                }
                if meal.nutrition.sodiumMg != 0 {
                    NutritionRow(label: "Sodium", value: meal.nutrition.sodiumMg, unit: "mg")
                }

                if meal.nutrition.fiberG != 0 {
                    NutritionRow(label: "Fiber", value: meal.nutrition.fiberG, unit: "g")
                }
                if meal.nutrition.sugarG != 0 {
                    NutritionRow(label: "Sugar", value: meal.nutrition.sugarG, unit: "g")
                }

                if meal.nutrition.vitaminAUg != 0 {
                    NutritionRow(label: "Vitamin A", value: meal.nutrition.vitaminAUg, unit: "µg")
                }
                if meal.nutrition.vitaminB6Mg != 0 {
                    NutritionRow(label: "Vitamin B6", value: meal.nutrition.vitaminB6Mg, unit: "mg")
                }
                if meal.nutrition.vitaminB12Ug != 0 {
                    NutritionRow(label: "Vitamin B12", value: meal.nutrition.vitaminB12Ug, unit: "µg")
                }
                if meal.nutrition.vitaminCMg != 0 {
                    NutritionRow(label: "Vitamin C", value: meal.nutrition.vitaminCMg, unit: "mg")
                }
                if meal.nutrition.vitaminDUg != 0 {
                    NutritionRow(label: "Vitamin D", value: meal.nutrition.vitaminDUg, unit: "µg")
                }
                if meal.nutrition.vitaminEMg != 0 {
                    NutritionRow(label: "Vitamin E", value: meal.nutrition.vitaminEMg, unit: "mg")
                }
                if meal.nutrition.vitaminKUg != 0 {
                    NutritionRow(label: "Vitamin K", value: meal.nutrition.vitaminKUg, unit: "µg")
                }
                if meal.nutrition.calciumMg != 0 {
                    NutritionRow(label: "Calcium", value: meal.nutrition.calciumMg, unit: "mg")
                }
                if meal.nutrition.ironMg != 0 {
                    NutritionRow(label: "Iron", value: meal.nutrition.ironMg, unit: "mg")
                }
                if meal.nutrition.thiaminMg != 0 {
                    NutritionRow(label: "Thiamin", value: meal.nutrition.thiaminMg, unit: "mg")
                }
                if meal.nutrition.riboflavinMg != 0 {
                    NutritionRow(label: "Riboflavin", value: meal.nutrition.riboflavinMg, unit: "mg")
                }
                if meal.nutrition.niacinMg != 0 {
                    NutritionRow(label: "Niacin", value: meal.nutrition.niacinMg, unit: "mg")
                }
                if meal.nutrition.folateUg != 0 {
                    NutritionRow(label: "Folate", value: meal.nutrition.folateUg, unit: "µg")
                }
                if meal.nutrition.biotinUg != 0 {
                    NutritionRow(label: "Biotin", value: meal.nutrition.biotinUg, unit: "µg")
                }
                if meal.nutrition.pantothenicAcidMg != 0 {
                    NutritionRow(label: "Pantothenic Acid", value: meal.nutrition.pantothenicAcidMg, unit: "mg")
                }
                if meal.nutrition.phosphorusMg != 0 {
                    NutritionRow(label: "Phosphorus", value: meal.nutrition.phosphorusMg, unit: "mg")
                }
                if meal.nutrition.iodineUg != 0 {
                    NutritionRow(label: "Iodine", value: meal.nutrition.iodineUg, unit: "µg")
                }
                if meal.nutrition.magnesiumMg != 0 {
                    NutritionRow(label: "Magnesium", value: meal.nutrition.magnesiumMg, unit: "mg")
                }
                if meal.nutrition.zincMg != 0 {
                    NutritionRow(label: "Zinc", value: meal.nutrition.zincMg, unit: "mg")
                }
                if meal.nutrition.seleniumUg != 0 {
                    NutritionRow(label: "Selenium", value: meal.nutrition.seleniumUg, unit: "µg")
                }
                if meal.nutrition.copperMg != 0 {
                    NutritionRow(label: "Copper", value: meal.nutrition.copperMg, unit: "mg")
                }
                if meal.nutrition.manganeseMg != 0 {
                    NutritionRow(label: "Manganese", value: meal.nutrition.manganeseMg, unit: "mg")
                }
                if meal.nutrition.chromiumUg != 0 {
                    NutritionRow(label: "Chromium", value: meal.nutrition.chromiumUg, unit: "µg")
                }
                if meal.nutrition.molybdenumUg != 0 {
                    NutritionRow(label: "Molybdenum", value: meal.nutrition.molybdenumUg, unit: "µg")
                }
                if meal.nutrition.chlorideMg != 0 {
                    NutritionRow(label: "Chloride", value: meal.nutrition.chlorideMg, unit: "mg")
                }
                if meal.nutrition.potassiumMg != 0 {
                    NutritionRow(label: "Potassium", value: meal.nutrition.potassiumMg, unit: "mg")
                }
                if meal.nutrition.caffeineMg != 0 {
                    NutritionRow(label: "Caffeine", value: meal.nutrition.caffeineMg, unit: "mg")
                }
                if meal.nutrition.waterL != 0 {
                    NutritionRow(label: "Water", value: meal.nutrition.waterL, unit: "L")
                }
                
                Spacer()
            }
            .navigationTitle("Meal Nutrients")
            .padding()
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
                .font(.caption2)
            Spacer()
            Text(Nutrition.getFormattedUnit(value: value, unit: unit))
                .font(.caption2)
        }
    }
}

struct NutritionRowWithImage: View {
    var label: String
    var value: Double
    var unit: String
    var image: String
    var imageColor: Color
    
    var body: some View {
        HStack {
            Text(label)
                .font(.caption2)
            Image(systemName: image)
                .foregroundStyle(imageColor)
            Spacer()
            Text(Nutrition.getFormattedUnit(value: value, unit: unit))
                .font(.caption2)
        }
    }
}


struct MealDetails_Previews: PreviewProvider {
    static var previews: some View {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: Meal.self, configurations: config)
        
        let meal = Meal(
            mealName: "Fried Chicken (Breast), One Piece",
            nutrition: Nutrition(
                energyConsumedKcal: 250,
                fatTotalG: 15,
                sodiumMg: 500,
                carbohydratesG: 0.25,
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
            ),
            consumedDate: Date()
        )
        
        return MealDetailsPage(meal: meal)
            .modelContainer(container)
    }
}
