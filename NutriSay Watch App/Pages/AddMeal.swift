//
//  AddMeal.swift
//  NutriSay Watch App
//
//  Created by Arya Adyatma on 16/05/24.
//

import SwiftUI
import HealthKit

enum AddMealPageState {
    case inputMeal
    case checkIcon
    case nutritionFacts
}

struct AddMeal: View {
    @State var clarificationText: String = "Enter your meal"
    @State var mealTextField: String = "100g fried chicken breast"
    @State var mealTextFieldHint: String = "Meal Info"
    @State var mealStatement: String = ""
    @State var nutritionFacts: NutritionFacts = NutritionFacts()
    @State var isLoading: Bool = false
    @State var hasFinished: Bool = false
    @State var pageState: AddMealPageState = .inputMeal

    @State private var isFirstLoad: Bool = true
    
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
            case .checkIcon:
                FinishedView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            pageState = .nutritionFacts
                        }
                    }
            case .nutritionFacts:
                NutritionFactsView()
            }
        }
        .onReceive(clarifierLLMViewModel.$response, perform: handleClarificationLLMResponse)
        .onReceive(nutritionLLMViewModel.$response, perform: handleNutritionLLMResponse)
        .onAppear(perform: handleOnAppear)
    }
    
    private func handleClarificationLLMResponse(_ response: String) {
        guard !response.isEmpty else { return }
        isLoading = false

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
            pageState = .checkIcon
            nutritionLLMViewModel.sendMessage(query: mealStatement)
        }
    }
    
    private func handleNutritionLLMResponse(_ response: String) {
        guard !response.isEmpty else { return }
        isLoading = false
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
            clarifierLLMViewModel.resetConversation()
            isFirstLoad = false
        }
    }
    
    private func next() {
        if mealTextField.isEmpty {
            return
        }
        isLoading = true
        clarifierLLMViewModel.sendMessage(query: mealTextField)
    }
}

struct FinishedView: View {
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
        }
    }
}

struct NutritionFactsView: View {
    var body: some View {
        Text("Nutrition Facts will be displayed here.")
    }
}

#Preview {
    AddMeal()
}
