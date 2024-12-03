import SwiftUI

struct ProgressViewExample: View {
    @State private var progress: Double = 0.3 // Example progress value

    var body: some View {
        ZStack {
            // Gradient Background
            LinearGradient(
                gradient: Gradient(colors: [AppTheme.primaryColor, AppTheme.accentColor]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {
                Text("Your Progress")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                // Progress Bar
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white.opacity(0.2))
                        .frame(height: 20)
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(AppTheme.accentColor)
                        .frame(width: CGFloat(progress) * UIScreen.main.bounds.width * 0.8, height: 20)
                        .animation(.easeInOut(duration: 0.5), value: progress)
                }
                .padding(.horizontal)

                Text("\(Int(progress * 100))% Completed")
                    .font(.headline)
                    .foregroundColor(.white)

                // Increase Progress Button
                Button(action: {
                    if progress < 1.0 {
                        progress += 0.1
                    }
                }) {
                    Text("Increase Progress")
                }
                .buttonStyle(CustomButtonStyle())
            }
            .padding()
        }
    }
}
