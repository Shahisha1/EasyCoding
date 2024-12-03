// ProfileView.swift
import SwiftUI
import PhotosUI

struct ProfileView: View {
    @State private var name: String = "Your Name"
    @State private var selectedImage: UIImage? = nil
    @State private var isPickerPresented = false

    var body: some View {
        VStack(spacing: 20) {
            // Profile Picture
            ZStack {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                        .shadow(radius: 5)
                } else {
                    Circle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(width: 120, height: 120)
                        .overlay(Text("Tap to Add").foregroundColor(.white))
                }
            }
            .onTapGesture {
                isPickerPresented = true
            }
            
            // Name
            TextField("Enter your name", text: $name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: 300)
            
            Spacer()
        }
        .padding()
        .sheet(isPresented: $isPickerPresented) {
            ImagePicker(selectedImage: $selectedImage)
        }
        .navigationTitle("Profile")
    }
}
