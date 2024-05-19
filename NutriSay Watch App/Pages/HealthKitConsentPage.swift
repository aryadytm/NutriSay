import SwiftUI
import HealthKit

struct HealthKitConsentPage: View {
    @State private var isAuthorized: Bool = false
    private let healthStore = HKHealthStore()
    
    var body: some View {
        VStack {
            if isAuthorized {
                MainMenu()
            } else {
                Text("HealthKit Access Required")
                Button(action: requestAuthorization) {
                    Text("Grant Access")
                }
            }
        }
        .onAppear(perform: checkAuthorization)
    }
    
    private func getAllTypes() -> Set<HKSampleType> {
        let nutritionIdentifiers: [HKQuantityTypeIdentifier] = [
            .dietaryEnergyConsumed, .dietaryFatTotal, .dietaryFatPolyunsaturated,
            .dietaryFatMonounsaturated, .dietaryFatSaturated, .dietaryCholesterol,
            .dietarySodium, .dietaryCarbohydrates, .dietaryFiber, .dietarySugar,
            .dietaryProtein, .dietaryVitaminA, .dietaryVitaminB6, .dietaryVitaminB12,
            .dietaryVitaminC, .dietaryVitaminD, .dietaryVitaminE, .dietaryVitaminK,
            .dietaryCalcium, .dietaryIron, .dietaryThiamin, .dietaryRiboflavin,
            .dietaryNiacin, .dietaryFolate, .dietaryBiotin, .dietaryPantothenicAcid,
            .dietaryPhosphorus, .dietaryIodine, .dietaryMagnesium, .dietaryZinc,
            .dietarySelenium, .dietaryCopper, .dietaryManganese, .dietaryChromium,
            .dietaryMolybdenum, .dietaryChloride, .dietaryPotassium, .dietaryCaffeine,
            .dietaryWater
        ]
        
        return Set(nutritionIdentifiers.compactMap { HKObjectType.quantityType(forIdentifier: $0) })
    }
    
    private func checkAuthorization() {
        let allTypes = getAllTypes()
        
        healthStore.getRequestStatusForAuthorization(toShare: allTypes, read: allTypes) { status, error in
            DispatchQueue.main.async {
                isAuthorized = (status == .unnecessary)
            }
        }
    }
    
    private func requestAuthorization() {
        let allTypes = getAllTypes()
        
        healthStore.requestAuthorization(toShare: allTypes, read: allTypes) { success, error in
            DispatchQueue.main.async {
                isAuthorized = success
            }
        }
    }
}

#Preview {
    HealthKitConsentPage()
}
