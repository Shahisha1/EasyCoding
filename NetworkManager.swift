import Foundation

struct NetworkingManager {
    static func executeCode(code: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://your-backend.com/api/execute") else {
            completion(.failure(NetworkingError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: String] = ["code": code]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkingError.invalidResponse))
                return
            }

            if let result = String(data: data, encoding: .utf8) {
                completion(.success(result))
            } else {
                completion(.failure(NetworkingError.decodingFailed))
            }
        }.resume()
    }

    enum NetworkingError: Error {
        case invalidURL
        case invalidResponse
        case decodingFailed
    }
}
