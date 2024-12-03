import SwiftUI
struct InteractiveExerciseView: View {
    let title: String
    let instruction: String
    @State private var userCode: String = "// Write your code here"
    @State private var output: String = "Output will appear here."
    @State private var isExecuting = false

    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.largeTitle)
                .bold()
                .padding()

            Text(instruction)
                .font(.body)
                .foregroundColor(.secondary)
                .padding(.horizontal)

            TextEditor(text: $userCode)
                .frame(height: 200)
                .border(Color.gray, width: 1)
                .cornerRadius(8)
                .padding()

            Button(action: {
                executeCode()
            }) {
                if isExecuting {
                    ProgressView()
                } else {
                    Text("Run Code")
                }
            }
            .buttonStyle(CustomButtonStyle())
            .padding(.horizontal)

            VStack(alignment: .leading) {
                Text("Output")
                    .font(.headline)
                    .padding(.bottom, 5)

                Text(output)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .border(Color.gray, width: 1)
                    .cornerRadius(8)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
    }

    private func executeCode() {
        isExecuting = true
        NetworkingManager.executeCode(code: userCode) { result in
            DispatchQueue.main.async {
                isExecuting = false
                switch result {
                case .success(let response):
                    output = response
                case .failure(let error):
                    output = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
}
