//
//  NutritionListPage.swift
//  NutriSay Watch App
//
//  Created by Arya Adyatma on 20/05/24.
//

import SwiftUI
import SwiftData

struct MealHistoryPage: View {
    @Query var meals: [Meal]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(groupMealsByDay(meals: Array(meals.prefix(100))), id: \.key) { day, meals in
                    Text(day)
                        .font(.headline)
                        .padding(.top, 16)
                    ForEach(meals) { meal in
                        ZStack {
                            NavigationLink(destination: MealDetailsPage(meal: meal)) {
                                MealItem(meal: meal)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("Meal History")
        }
        
    }
    
    private func groupMealsByDay(meals: [Meal]) -> [(key: String, value: [Meal])] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!
        
        let groupedMeals = Dictionary(grouping: meals) { meal -> String in
            let mealDate = calendar.startOfDay(for: meal.consumedDate)
            if (mealDate == today) {
                return "Today"
            } else if (mealDate == yesterday) {
                return "Yesterday"
            } else {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE, dd MMM yyyy"
                return dateFormatter.string(from: mealDate)
            }
        }
        
        let sortedGroupedMeals = groupedMeals
            .map { (key, value) in
                (key: key, value: value.sorted { $0.consumedDate > $1.consumedDate })
            }
            .sorted { lhs, rhs in
                let lhsDate = dateFromString(lhs.key)
                let rhsDate = dateFromString(rhs.key)
                return lhsDate > rhsDate
            }
        
        return sortedGroupedMeals
    }
    
    private func dateFromString(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, dd MMM yyyy"
        
        switch dateString {
        case "Today":
            return Calendar.current.startOfDay(for: Date())
        case "Yesterday":
            return Calendar.current.date(byAdding: .day, value: -1, to: Calendar.current.startOfDay(for: Date()))!
        default:
            return dateFormatter.date(from: dateString) ?? Date.distantPast
        }
    }
}

struct MealItem: View {
    var meal: Meal
    
    var body: some View {
        let energyConsumed = Nutrition
            .getFormattedUnit(value: meal.nutrition.energyConsumedKcal, unit: "")
            .split(separator: ".")[0]
            .replacing(" ", with: "")
        let protein = Nutrition
            .getFormattedUnit(value: meal.nutrition.proteinG, unit: "")
            .split(separator: ".")[0]
            .replacing(" ", with: "")
        let carbohydrates = Nutrition
            .getFormattedUnit(value: meal.nutrition.carbohydratesG, unit: "")
            .split(separator: ".")[0]
            .replacing(" ", with: "")

        
        return VStack(alignment: .leading, spacing: 4) {
            HStack {
                Image(systemName: "square.fill")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .foregroundStyle(.green)
 
                VStack(alignment: .leading) {
                    HStack {
                        Text(meal.mealName)
                            .font(.caption)
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    Text(meal.getDateString().split(separator: "\n")[1])
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.leading, 4)
            }
            
            HStack {
                Image(systemName: "bolt.fill")
                    .foregroundStyle(.yellow)
                Text("\(energyConsumed)")
                    .font(.caption2)
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: "dumbbell.fill")
                    .foregroundStyle(.blue)
                Text("\(protein)g")
                    .font(.caption2)
                    .foregroundColor(.primary)
                Spacer()
                Image(systemName: "cube.fill")
                    .foregroundStyle(.purple)
                Text("\(carbohydrates)g")
                    .font(.caption2)
                    .foregroundColor(.primary)

            }

        }
        .padding()
        .background(Color(.white).opacity(0.1))
        .cornerRadius(8)
        .shadow(radius: 2)
    }
}

#Preview {
    let calendar = Calendar.current
    let today = Date()
    let meals: [Meal] = (0..<9).map { offset in
        let date = calendar.date(byAdding: .day, value: -offset, to: today)!
        return Meal(
            mealName: "Meal \(offset + 1)",
            nutrition: Nutrition(
                energyConsumedKcal: Double.random(in: 50...250),
                fatTotalG: Double.random(in: 10...50),
                sodiumMg: Double.random(in: 10...50),
                carbohydratesG: Double.random(in: 10...50),
                fiberG: Double.random(in: 10...50),
                sugarG: Double.random(in: 10...50),
                proteinG: Double.random(in: 10...50),
                vitaminAUg: Double.random(in: 10...50),
                vitaminB6Mg: Double.random(in: 10...50),
                vitaminB12Ug: Double.random(in: 10...50),
                vitaminCMg: Double.random(in: 10...50),
                vitaminDUg: Double.random(in: 10...50),
                vitaminEMg: Double.random(in: 10...50),
                vitaminKUg: Double.random(in: 10...50),
                calciumMg: Double.random(in: 10...50),
                ironMg: Double.random(in: 10...50),
                thiaminMg: Double.random(in: 10...50),
                riboflavinMg: Double.random(in: 10...50),
                niacinMg: Double.random(in: 10...50),
                folateUg: Double.random(in: 10...50),
                biotinUg: Double.random(in: 10...50),
                pantothenicAcidMg: Double.random(in: 10...50),
                phosphorusMg: Double.random(in: 10...50),
                iodineUg: Double.random(in: 10...50),
                magnesiumMg: Double.random(in: 10...50),
                zincMg: Double.random(in: 10...50),
                seleniumUg: Double.random(in: 10...50),
                copperMg: Double.random(in: 10...50),
                manganeseMg: Double.random(in: 10...50),
                chromiumUg: Double.random(in: 10...50),
                molybdenumUg: Double.random(in: 10...50),
                chlorideMg: Double.random(in: 10...50),
                potassiumMg: Double.random(in: 10...50),
                caffeineMg: Double.random(in: 10...50),
                waterL: Double.random(in: 10...50)
            ),
            consumedDate: date
        )
    }
    
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Meal.self, configurations: config)
    
    for meal in meals {
        container.mainContext.insert(meal)
    }
    
    return NavigationStack {
        MealHistoryPage()
    }
    .modelContainer(container)
}
