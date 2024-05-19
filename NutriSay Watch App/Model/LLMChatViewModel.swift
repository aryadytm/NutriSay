//
//  ChatViewModel.swift
//  NutriSay Watch App
//
//  Created by Arya Adyatma on 17/05/24.
//

import Foundation
import Combine

enum LLMIdentifier: String {
    case mealClarifier = "app-2tp31J7OqtYfzWK79gKPnYB0"
    case nutritionExaminer = "app-WHsw9wSqoMynEKgqmhpZDYBS"
}

class LLMChatViewModel: ObservableObject {
    var llmIdentifier: String
    var useStreaming: Bool
    var isConversation: Bool
    
    init(identifier: String, useStreaming: Bool, isConversation: Bool) {
        self.llmIdentifier = identifier
        self.useStreaming = useStreaming
        self.isConversation = isConversation
    }
    
    @Published var response: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    private var conversationId = ""
    
    func sendMessage(query: String) {
        response = ""
        
        guard let url = URL(string: "https://api.dify.ai/v1/chat-messages") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(llmIdentifier)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "inputs": [:],
            "query": query,
            "response_mode": "blocking",
            "conversation_id": conversationId,
            "user": "abc-123",
            "files": []
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { output -> Data in
                guard let httpResponse = output.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: LLMBlockingResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    self.response = "Error: \(error.localizedDescription)"
                case .finished:
                    break
                }
            }, receiveValue: { blockingResponse in
                self.handleBlockingResponse(blockingResponse)
            })
            .store(in: &cancellables)
    }
    
    private func handleBlockingResponse(_ blockingResponse: LLMBlockingResponse) {
        if blockingResponse.event == "message" {
            response += blockingResponse.answer ?? ""
        }
        if conversationId.isEmpty && isConversation {
            conversationId = blockingResponse.conversation_id ?? ""
        }
    }
    
    func resetConversation() {
        conversationId = ""
    }
}

// Define the blocking response model
struct LLMBlockingResponse: Decodable {
    let event: String
    let message_id: String?
    let conversation_id: String?
    let answer: String?
    let created_at: Int?
}
