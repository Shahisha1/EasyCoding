import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            // Gradient Background
            LinearGradient(
                gradient: Gradient(colors: [AppTheme.primaryColor, AppTheme.accentColor]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 30) {
                Text("Welcome to EasyCoding")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)

                Image(systemName: "laptopcomputer.and.arrow.down")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.white)

                VStack(spacing: 15) {
                    NavigationLink(destination: LessonView()) {
                        Text("Start Learning")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.8))
                            .foregroundColor(AppTheme.primaryColor)
                            .cornerRadius(10)
                    }
                    NavigationLink(destination: QuizView()) {
                        Text("Take a Quiz")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white.opacity(0.8))
                            .foregroundColor(AppTheme.accentColor)
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
        }
    }
}
