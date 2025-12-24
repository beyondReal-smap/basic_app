import Foundation

@MainActor
class AuthViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let baseURL = "http://localhost:8000" // Change to actual server URL
    
    func register(name: String, email: String, password: String) async -> Bool {
        isLoading = true
        errorMessage = nil
        
        guard let url = URL(string: "\(baseURL)/register") else { return false }
        
        let body: [String: String] = [
            "name": name,
            "email": email,
            "password": password
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                errorMessage = "Invalid response from server"
                isLoading = false
                return false
            }
            
            if httpResponse.statusCode == 200 {
                isLoading = false
                return true
            } else {
                // Parse error message
                if let errorDict = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                   let detail = errorDict["detail"] as? String {
                    errorMessage = detail
                } else {
                    errorMessage = "Registration failed (\(httpResponse.statusCode))"
                }
                isLoading = false
                return false
            }
        } catch {
            errorMessage = error.localizedDescription
            isLoading = false
            return false
        }
    }
}
