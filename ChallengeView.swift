// ChallengeView.swift
import SwiftUI

struct ChallengeView: View {
    @State private var codeInput: String = "// Write your code here"

    var body: some View {
        VStack {
            Text("Practice Coding")
                .font(.headline)
            CodeEditorView(code: $codeInput)
                .frame(height: 300)
                .border(Color.gray)
            
            Button("Run Code") {
                runCode(codeInput)
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
        .padding()
    }
    
    func runCode(_ code: String) {
        // Integration with backend or local interpreter goes here
        print("Code to run: \(code)")
    }
}
