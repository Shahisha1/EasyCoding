import SwiftUI
import AVKit

struct LessonDetailView: View {
    let title: String
    let description: String
    let resources: [Resource]
    let videoURL: URL?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                // Lesson Title
                Text(title)
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom)

                // Lesson Description
                Text(description)
                    .font(.body)
                    .foregroundColor(.secondary)

                Divider()

                // Video Section
                if let videoURL = videoURL {
                    Text("Watch Video")
                        .font(.headline)
                        .padding(.bottom, 5)

                    VideoPlayer(player: AVPlayer(url: videoURL))
                        .frame(height: 250)
                        .cornerRadius(10)
                        .padding(.bottom)
                }

                // Resources Section
                Text("Learn More")
                    .font(.headline)
                    .padding(.bottom, 5)

                ForEach(resources, id: \.name) { resource in
                    Link(resource.name, destination: URL(string: resource.url)!)
                        .font(.body)
                        .foregroundColor(AppTheme.primaryColor)
                        .padding(.vertical, 5)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle(title)
    }
}
