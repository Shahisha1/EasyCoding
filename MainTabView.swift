import SwiftUI
struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationView {
                HomeView()
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }

            NavigationView {
                LessonView()
            }
            .tabItem {
                Label("Courses", systemImage: "book")
            }

            NavigationView {
                QuizView()
            }
            .tabItem {
                Label("Quiz", systemImage: "questionmark.circle")
            }

            NavigationView {
                AIChatView()
            }
            .tabItem {
                Label("AI Assistant", systemImage: "brain")
            }

            NavigationView {
                FlashcardView()
            }
            .tabItem {
                Label("Flashcards", systemImage: "rectangle.stack")
            }

            NavigationView {
                SettingsView()
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape")
            }
        }
        .accentColor(AppTheme.primaryColor)
    }
}
