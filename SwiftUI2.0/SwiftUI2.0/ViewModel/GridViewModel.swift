import Foundation
import Combine

enum APIError: Error, LocalizedError {
    case unknown
    case apiError(reason: String)
    case parseError(reason: String)
    case networkError(from: URLError)
    
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown Error"
        case .apiError(let reason), .parseError(let reason):
            return reason
        case .networkError(let from):
            return from.localizedDescription
        }
    }
}

class GridViewModel: ObservableObject {
    
    private var cancellable: AnyCancellable?
    @Published var results = [Results]()
    @Published var isLoading = Bool()
    
    init() {
        
        self.isLoading = true
        
        guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/in/ios-apps/top-free/all/100/explicit.json") else { return }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw APIError.unknown
                }
                if httpResponse.statusCode == 401 {
                    throw APIError.apiError(reason: "Unauthorized")
                }
                if httpResponse.statusCode == 403 {
                    throw APIError.apiError(reason: "Resource forbidden")
                }
                if httpResponse.statusCode == 404 {
                    throw APIError.apiError(reason: "Resource not found")
                }
                if (405..<500 ~= httpResponse.statusCode) {
                    throw APIError.apiError(reason: "client error")
                }
                if (500..<600 ~= httpResponse.statusCode) {
                    throw APIError.apiError(reason: "server error")
                }
                return data
            }
            .decode(type: RSS.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { (subscriberCompletion) in
                switch subscriberCompletion {
                case .finished:
                    self.isLoading = false
                    break 
                    
                case .failure(let error):
                    self.isLoading = false
                    print(error.localizedDescription)
                    
                }
            }, receiveValue: { [weak self] (rss) in
                self?.isLoading = false
                self?.results.append(contentsOf: rss.feed.results)
            })
        
    }
    
    deinit {
        cancellable?.cancel()
    }
}

