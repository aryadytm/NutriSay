//import SwiftUI
//
//struct ChatView: View {
//    @StateObject private var viewModel = LLMChatViewModel(identifier: LLMIdentifier.mealClarifier.rawValue)
//    
//    @State private var query: String = ""
//    @State private var isFirstLoad: Bool = true
//
//    var body: some View {
//        ScrollView {
//            VStack {
//                TextField("Query", text: $query)
//                    .padding()
//                
//                Button(action: {
//                    viewModel.sendMessage(query: query)
//                }) {
//                    Text("Send")
//                        .padding()
//                }
//                .padding()
//                
//                
//                Text(viewModel.response)
//                    .padding()
//                
//                Spacer()
//            }
//            .padding()
//        }
//        .onAppear {
//            if isFirstLoad {
//                viewModel.resetConversation()
//                isFirstLoad = false
//            }
//        }
//    }
//}
//
//#Preview {
//    ChatView()
//}
