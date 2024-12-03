import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Welcome to EasyCoding")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(AppTheme.primaryColor)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 15) {
                    NavigationLink("Start Learning", destination: LessonView())
                        .buttonStyle(CustomButtonStyle())
                    
                    NavigationLink("Practice Challenges", destination: ChallengeView())
                        .buttonStyle(CustomButtonStyle())
                    
                    NavigationLink("View Progress", destination: ProgressViewExample())
                        .buttonStyle(CustomButtonStyle())
                    
                    NavigationLink("Profile", destination: ProfileView())
                        .buttonStyle(CustomButtonStyle())
                    
                    NavigationLink("Quiz", destination: QuizView())
                        .buttonStyle(CustomButtonStyle())
                    
                    NavigationLink("Settings", destination: SettingsView())
                        .buttonStyle(CustomButtonStyle())
                }
                .padding()
            }
            .padding()
            .background(AppTheme.backgroundColor.ignoresSafeArea())
            .navigationTitle("EasyCoding")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
