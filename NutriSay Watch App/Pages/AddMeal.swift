//
//  AddMeal.swift
//  NutriSay Watch App
//
//  Created by Arya Adyatma on 16/05/24.
//

import SwiftUI
import HealthKit

struct AddMeal: View {
    @State var clarificationText: String = "Enter your meal"
    @State var mealTextField: String = "100g fried chicken breast"
    @State var mealTextFieldHint: String = "Meal Info"
    @State var mealStatement: String = ""
    @State var hasFinished: Bool = false
    @State var nutritionFacts: NutritionFacts = NutritionFacts()
    
    @State private var isFirstLoad: Bool = true
    
    @StateObject private var llmViewModel = LLMChatViewModel(
        identifier: LLMIdentifier.mealClarifier.rawValue,
        useStreaming: false,
        isConversation: true
    )
    
    @StateObject private var nutritionViewModel = LLMChatViewModel(
        identifier: LLMIdentifier.nutritionExaminer.rawValue,
        useStreaming: false,
        isConversation: false
    )
    
    var body: some View {
        ScrollView {
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
                Button(action: next) {
                    Text("Next")
                }
            }
            .onReceive(llmViewModel.$response, perform: handleClarificationLLMResponse)
            .onReceive(nutritionViewModel.$response, perform: handleNutritionLLMResponse)
            .onAppear(perform: handleOnAppear)
        }
    }
    
    private func handleClarificationLLMResponse(_ response: String) {
        guard !response.isEmpty else { return }
        
        print("===============================")
        
        if response.starts(with: "/clarification") {
            clarificationText = response.replacingOccurrences(of: "/clarification", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
            mealTextField = ""
            mealTextFieldHint = "Meal Details"
        } else if response.starts(with: "/finish") {
            mealStatement = response.replacingOccurrences(of: "/finish", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
            mealTextField = ""
            mealTextFieldHint = ""
            hasFinished = true
            nutritionViewModel.sendMessage(query: mealStatement)
        }
    }
    
    private func handleNutritionLLMResponse(_ response: String) {
        guard !response.isEmpty else { return }
        if let facts = NutritionFacts.fromYamlString(response) {
            nutritionFacts = facts
            print(response)
            print(nutritionFacts)
            NutritionUtils.logNutritionFactsToHealthKit(facts)
            hasFinished = true
        }
    }
    
    private func handleOnAppear() {
        if isFirstLoad {
            llmViewModel.resetConversation()
            isFirstLoad = false
        }
    }
    
    private func next() {
        if mealTextField.isEmpty {
            return
        }
        llmViewModel.sendMessage(query: mealTextField)
    }
    
}

#Preview {
    AddMeal()
}
