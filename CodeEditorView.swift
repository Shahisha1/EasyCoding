// CodeEditorView.swift
import SwiftUI

struct CodeEditorView: UIViewRepresentable {
    @Binding var code: String

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = UIFont.monospacedSystemFont(ofSize: 16, weight: .regular)
        textView.backgroundColor = UIColor.systemGray6
        textView.textColor = UIColor.label
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        textView.delegate = context.coordinator
        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = code
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: CodeEditorView

        init(_ parent: CodeEditorView) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            parent.code = textView.text
        }
    }
}
