import Foundation

struct AIManager {
    static func askAI(prompt: String, endpoint: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://your-backend.com/api/ai/\(endpoint)") else {
            completion(.failure(AIError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: String] = ["prompt": prompt]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(AIError.invalidResponse))
                return
            }

            if let result = String(data: data, encoding: .utf8) {
                completion(.success(result))
            } else {
                completion(.failure(AIError.decodingFailed))
            }
        }.resume()
    }

    enum AIError: Error {
        case invalidURL
        case invalidResponse
        case decodingFailed
    }
}
