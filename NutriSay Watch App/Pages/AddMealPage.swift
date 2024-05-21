//
//  AddMeal.swift
//  NutriSay Watch App
//
//  Created by Arya Adyatma on 16/05/24.
//

import SwiftUI
import HealthKit
import SwiftData

enum AddMealPageState {
    case inputMeal
    case success
    case showMealDetails
}

struct AddMealPage: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var meal: Meal = Meal.getEmpty()
    
    @State var clarificationText: String = "Enter your meal"
    @State var mealTextField: String = ""
    @State var mealTextFieldHint: String = "Meal Info"
    @State var mealStatement: String = ""
    
    @State var isLoading: Bool = false
    @State var isFirstLoad: Bool = true
    
    @State var pageState: AddMealPageState = .inputMeal
    @State var nutritionFacts: Nutrition = Nutrition()
    
    @StateObject private var clarifierLLMViewModel = LLMChatViewModel(
        identifier: LLMIdentifier.mealClarifier.rawValue,
        useStreaming: false,
        isConversation: true
    )
    
    @StateObject private var nutritionLLMViewModel = LLMChatViewModel(
        identifier: LLMIdentifier.nutritionExaminer.rawValue,
        useStreaming: false,
        isConversation: false
    )
    
    let mealExamples = [
        "One cup of coffee",
        "One cup of tea",
        "Milk tea 250g",
        "Fried chicken",
        "Beef steak",
        "Pork rice",
        "Wagyu tokusen 150g",
        "Caesar salad",
        "Fried rice",
        "Orange juice",
        "Vitamin C",
    ]
    
    var body: some View {
        ScrollView {
            switch pageState {
            case .inputMeal:
                InputMealView(
                    clarificationText: $clarificationText,
                    mealTextField: $mealTextField,
                    mealTextFieldHint: $mealTextFieldHint,
                    isLoading: $isLoading,
                    nextAction: next
                )
            case .success:
                SuccessView()
            case .showMealDetails:
                MealDetailsPage(meal: meal)
            }
        }
        .padding(.horizontal)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.green.opacity(0.01), Color.green.opacity(0.0)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
        )
        .onReceive(clarifierLLMViewModel.$response, perform: handleClarificationLLMResponse)
        .onReceive(nutritionLLMViewModel.$response, perform: handleNutritionLLMResponse)
        .onAppear(perform: handleOnAppear)
    }
    
    private func handleClarificationLLMResponse(_ response: String) {
        guard !response.isEmpty else { return }

        print("===============================")
        
        if response.starts(with: "/clarification") {
            isLoading = false
            clarificationText = response.replacingOccurrences(of: "/clarification", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
            mealTextField = ""
            mealTextFieldHint = "Meal Details"
        }
        else if response.starts(with: "/finish") {
            mealStatement = response.replacingOccurrences(of: "/finish", with: "").trimmingCharacters(in: .whitespacesAndNewlines)

            nutritionLLMViewModel.sendMessage(query: mealStatement)
        }
    }
    
    private func handleNutritionLLMResponse(_ response: String) {
        guard !response.isEmpty else { return }
        
        if let facts = Nutrition.fromYamlString(response) {
            nutritionFacts = facts
            
//            print(response)
//            print(nutritionFacts)
            
            NutritionUtils.logNutritionFactsToHealthKit(facts)
            
            let newMeal = Meal(
                mealName: mealStatement,
                nutrition: nutritionFacts,
                consumedDate: Date()
            )
            
            modelContext.insert(newMeal)
            
            self.meal.mealName = newMeal.mealName
            self.meal.nutrition = newMeal.nutrition
            self.meal.consumedDate = newMeal.consumedDate

            pageState = .success
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                pageState = .showMealDetails
                isLoading = false
                mealTextField = ""
                mealTextFieldHint = ""
            }

        }
    }
    
    private func handleOnAppear() {
        if isFirstLoad {
            clarifierLLMViewModel.resetConversation()
            isFirstLoad = false
        }
        mealTextFieldHint = mealExamples.randomElement() ?? "Meal Info"
    }
    
    private func next() {
        if mealTextField.isEmpty {
            return
        }
        isLoading = true
        clarifierLLMViewModel.sendMessage(query: mealTextField)
    }
}

struct SuccessView: View {
    var body: some View {
        Spacer()
        VStack {
            Spacer()
            Image(systemName: "checkmark.seal.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
                .padding(.top)
                .transition(.symbolEffect(.appear))
            Spacer()
        }
        Spacer()
    }
}

struct InputMealView: View {
    @Binding var clarificationText: String
    @Binding var mealTextField: String
    @Binding var mealTextFieldHint: String
    @Binding var isLoading: Bool
    var nextAction: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text(clarificationText)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .lineLimit(5)
                    .truncationMode(.tail)
                Spacer()
            }
            TextField(mealTextFieldHint, text: $mealTextField)
                .padding(.bottom)
            Button(action: nextAction) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    Text("Next")
                }
            }
            .disabled(isLoading)
        }
        
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Meal.self, configurations: config)
    return AddMealPage()
        .modelContainer(container)
}
