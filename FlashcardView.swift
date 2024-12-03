import SwiftUI

struct FlashcardView: View {
    @StateObject private var manager = FlashcardManager()
    @State private var showAddCard = false
    @State private var newQuestion = ""
    @State private var newAnswer = ""

    var body: some View {
        VStack<Content: View> {
            List(manager.flashcards) { card in
                FlashcardCard(question: card.question, answer: card.answer)
            }

            Button(action: {
                showAddCard.toggle()
            }) {
                Text("Add Flashcard")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(AppTheme.primaryColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .sheet(isPresented: $showAddCard) {
            VStack {
                TextField("Question", text: $newQuestion)
                    .padding()
                    .border(Color.gray)

                TextField("Answer", text: $newAnswer)
                    .padding()
                    .border(Color.gray)

                Button("Save") {
                    manager.addFlashcard(question: newQuestion, answer: newAnswer)
                    newQuestion = ""
                    newAnswer = ""
                    showAddCard = false
                }
                .buttonStyle(CustomButtonStyle())
                .padding()
            }
            .padding()
        }
        .navigationTitle("Flashcards")
    }
}

struct FlashcardCard: View {
    let question: String
    let answer: String
    @State private var showAnswer = false

    var body: some View {
        VStack {
            Text(showAnswer ? answer : question)
                .font(.title2)
                .padding()
                .frame(maxWidth: .infinity)
                .background(AppTheme.cardBackground)
                .cornerRadius(12)
                .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)

            Button(showAnswer ? "Show Question" : "Show Answer") {
                showAnswer.toggle()
            }
            .padding(.top, 5)
        }
    }
}
Button("Generate Flashcards") {
    flashcardManager.generateFlashcards(prompt: "Create flashcards about Python basics.")
}
.buttonStyle(CustomButtonStyle())
.padding()
