import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var notificationsEnabled = true
    @State private var showResetAlert = false

    var body: some View {
        Form {
            Section(header: Text("Appearance")) {
                Toggle("Dark Mode", isOn: $isDarkMode)
            }

            Section(header: Text("Notifications")) {
                Toggle("Enable Reminders", isOn: $notificationsEnabled)
            }

            Section(header: Text("Account")) {
                Button(action: {
                    showResetAlert = true
                }) {
                    Text("Reset Progress")
                        .foregroundColor(.red)
                }
                .alert(isPresented: $showResetAlert) {
                    Alert(
                        title: Text("Reset Progress"),
                        message: Text("Are you sure you want to reset all progress? This action cannot be undone."),
                        primaryButton: .destructive(Text("Reset")) {
                            resetProgress()
                        },
                        secondaryButton: .cancel()
                    )
                }
            }

            Section(header: Text("Help & Feedback")) {
                Link("Contact Support", destination: URL(string: "mailto:support@easycoding.com")!)
                Link("Privacy Policy", destination: URL(string: "https://www.easycoding.com/privacy")!)
            }
        }
        .navigationTitle("Settings")
    }

    private func resetProgress() {
        // Reset logic goes here
        print("Progress has been reset.")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
