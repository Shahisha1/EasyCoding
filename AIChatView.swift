import SwiftUI

struct AIChatView: View {
    @State private var query: String = ""
    @State private var response: String = "Hello! How can I help you today?"
    @State private var queryType: String = "General"
    @State private var isThinking = false

    let queryTypes = ["General", "Code Debugging", "Quiz Generator", "Flashcard Generator", "Project Ideas"]

    var body: some View {
        VStack {
            // Query Type Selector
            Picker("Query Type", selection: $queryType) {
                ForEach(queryTypes, id: \.self) { type in
                    Text(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            // Chat Display
            ScrollView {
                Text(response)
                    .font(.body)
                    .foregroundColor(.primary)
                    .padding()
                    .background(AppTheme.cardBackground)
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
            }
            .padding(.vertical)

            Spacer()

            // User Input
            HStack {
                TextField("Type your query...", text: $query)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                if isThinking {
                    ProgressView()
                        .padding()
                } else {
                    Button("Send") {
                        handleQuery()
                    }
                    .buttonStyle(CustomButtonStyle())
                }
            }
            .padding()
        }
        .padding()
        .navigationTitle("AI Assistant")
    }

    private func handleQuery() {
        guard !query.isEmpty else { return }
        isThinking = true

        let endpoint: String
        switch queryType {
        case "Code Debugging":
            endpoint = "assistant"
        case "Quiz Generator":
            endpoint = "quiz-generator"
        case "Flashcard Generator":
            endpoint = "flashcards"
        case "Project Ideas":
            endpoint = "assistant"
        default:
            endpoint = "assistant"
        }

        AIManager.askAI(prompt: query, endpoint: endpoint) { result in
            DispatchQueue.main.async {
                isThinking = false
                switch result {
                case .success(let aiResponse):
                    response = aiResponse
                case .failure(let error):
                    response = "Error: \(error.localizedDescription)"
                }
                query = ""
            }
        }
    }
}
