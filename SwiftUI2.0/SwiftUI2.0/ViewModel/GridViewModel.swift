import Foundation
import Combine

class GridViewModel: ObservableObject {
    
    private var cancellable: AnyCancellable?
    @Published var results = [Results]()
    @Published var isLoading = Bool()
    
    init() {
        
        self.isLoading = true
        
        guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/in/ios-apps/top-free/all/100/explicit.json") else { return }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
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

