import SwiftUI

struct QuizView: View {
    @State private var selectedCategory = "Python"
    @State private var currentQuestionIndex = 0
    @State private var selectedAnswer: String? = nil
    @State private var showFeedback = false
    @State private var score = 0

    let categories = ["Python", "JavaScript", "Java", "C++"]

    var questions: [Question] {
        switch selectedCategory {
        case "Python":
            return QuestionBank.pythonQuestions
        // Add JavaScript, Java, C++ cases here.
        default:
            return []
        }
    }

    var body: some View {
        VStack {
            Picker("Select Category", selection: $selectedCategory) {
                ForEach(categories, id: \.self) { category in
                    Text(category)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            if !questions.isEmpty {
                Text("Question \(currentQuestionIndex + 1) of \(questions.count)")
                    .font(.headline)

                Text(questions[currentQuestionIndex].text)
                    .padding()

                ForEach(questions[currentQuestionIndex].options, id: \.self) { option in
                    Button(action: {
                        selectedAnswer = option
                        checkAnswer()
                    }) {
                        Text(option)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(selectedAnswer == option ? Color.blue.opacity(0.7) : Color.gray.opacity(0.2))
                            .cornerRadius(8)
                    }
                }

                if showFeedback {
                    Text(selectedAnswer == questions[currentQuestionIndex].correctAnswer ? "Correct!" : "Incorrect!")
                        .foregroundColor(selectedAnswer == questions[currentQuestionIndex].correctAnswer ? .green : .red)
                        .padding()

                    Button("Next") {
                        moveToNextQuestion()
                    }
                }
            } else {
                Text("No questions available for this category.")
            }

            Spacer()
        }
        .padding()
    }

    private func checkAnswer() {
        if selectedAnswer == questions[currentQuestionIndex].correctAnswer {
            score += 1
        }
        showFeedback = true
    }

    private func moveToNextQuestion() {
        showFeedback = false
        selectedAnswer = nil
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            currentQuestionIndex = 0
            score = 0
        }
    }
}
Button("Generate Quiz Questions") {
    AIManager.askAI(prompt: "Generate 5 quiz questions about Swift.", endpoint: "quiz-generator") { result in
        DispatchQueue.main.async {
            switch result {
            case .success(let quizData):
                // Parse AI response into questions
                let newQuestions = parseQuizQuestions(from: quizData)
                questions.append(contentsOf: newQuestions)
            case .failure(let error):
                print("Error generating quiz questions: \(error.localizedDescription)")
            }
        }
    }
}
private func parseQuizQuestions(from text: String) -> [Question] {
    var questions: [Question] = []
    let entries = text.split(separator: "\n")
    for entry in entries {
        let parts = entry.split(separator: "|") // e.g., "Question | Option1, Option2, Option3 | CorrectAnswer"
        if parts.count == 3 {
            let options = parts[1].split(separator: ",").map { String($0) }
            questions.append(Question(text: String(parts[0]), options: options, correctAnswer: String(parts[2])))
        }
    }
    return questions
}
