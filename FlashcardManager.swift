import Foundation
class FlashcardManager: ObservableObject {
    @Published var flashcards: [Flashcard] = []

    func generateFlashcards(prompt: String) {
        AIManager.askAI(prompt: prompt, endpoint: "flashcards") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let flashcardData):
                    // Parse AI response into flashcards
                    self.flashcards = self.parseFlashcards(from: flashcardData)
                case .failure(let error):
                    print("Error generating flashcards: \(error.localizedDescription)")
                }
            }
        }
    }

    private func parseFlashcards(from text: String) -> [Flashcard] {
        // Example: Parse response (e.g., "Question: What is Python?\nAnswer: A programming language.")
        var cards: [Flashcard] = []
        let entries = text.split(separator: "\n")
        for entry in entries {
            let parts = entry.split(separator: ":")
            if parts.count == 2 {
                cards.append(Flashcard(question: String(parts[0]), answer: String(parts[1])))
            }
        }
        return cards
    }
}
