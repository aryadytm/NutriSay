import SwiftUI

struct MealDetails: View {
    var mealName: String
    var nutritionData: NutritionData
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(mealName)
                    .font(.headline)
                    .foregroundColor(Color.green)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
                    .padding(.bottom, 10)
                
                NutritionRow(label: "Calories", value: nutritionData.energyConsumedKcal, unit: "kcal")
                NutritionRow(label: "Total Fat", value: nutritionData.fatTotalG, unit: "g")
                NutritionRow(label: "Carbohydrates", value: nutritionData.carbohydratesG, unit: "g")
                NutritionRow(label: "Protein", value: nutritionData.proteinG, unit: "g")
                // Add more rows as needed
                
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
            Text("\(value, specifier: "%.2f") \(unit)")
                .font(.caption)
        }
    }
}

struct NutritionData {
    var energyConsumedKcal: Double
    var fatTotalG: Double
    var carbohydratesG: Double
    var proteinG: Double
    // Add more properties as needed
}

struct MealDetails_Previews: PreviewProvider {
    static var previews: some View {
        MealDetails(
            mealName: "Fried Chicken (Breast), One Piece",
            nutritionData: NutritionData(
                energyConsumedKcal: 250,
                fatTotalG: 15,
                carbohydratesG: 0,
                proteinG: 26
            )
        )
    }
}
