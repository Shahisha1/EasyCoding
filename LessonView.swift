import SwiftUI

struct LessonView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Section(header: Text("Beginner").font(.title3).bold()) {
                    LessonCard(
                        title: "Variables and Constants",
                        description: "Learn how to declare and use variables and constants in Swift.",
                        videoURL: URL(string: "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4"),
                        exerciseTitle: "Variables Exercise",
                        exerciseInstructions: "Write a Swift program that declares a constant and prints its value."
                    )
                    LessonCard(
                        title: "Control Flow",
                        description: "Understand loops, conditions, and branching in Swift.",
                        videoURL: URL(string: "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4"),
                        exerciseTitle: "Control Flow Exercise",
                        exerciseInstructions: "Write a Swift program that uses a loop to print numbers 1 to 10."
                    )
                }

                Section(header: Text("Intermediate").font(.title3).bold()) {
                    LessonCard(
                        title: "Optionals",
                        description: "Understand optional types and safely unwrapping them.",
                        videoURL: URL(string: "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_480_1_5MG.mp4"),
                        exerciseTitle: "Optionals Exercise",
                        exerciseInstructions: "Write a Swift program that declares an optional integer and prints its value after unwrapping."
                    )
                }
            }
            .padding()
        }
        .navigationTitle("Courses")
    }
}

struct LessonCard: View {
    let title: String
    let description: String
    let videoURL: URL?
    let exerciseTitle: String
    let exerciseInstructions: String

    var body: some View {
        CardView {
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(AppTheme.primaryColor)

                Text(description)
                    .font(.body)
                    .foregroundColor(AppTheme.secondaryTextColor)

                HStack {
                    NavigationLink("Watch Video", destination: VideoPlayerView(videoURL: videoURL))
                        .buttonStyle(CustomButtonStyle())
                    Spacer()
                    NavigationLink("Exercise", destination: InteractiveExerciseView(title: exerciseTitle, instruction: exerciseInstructions))
                        .buttonStyle(CustomButtonStyle())
                }
            }
        }
    }
}
