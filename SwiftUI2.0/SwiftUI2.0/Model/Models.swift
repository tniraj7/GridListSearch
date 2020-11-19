import Foundation

struct RSS : Decodable {
    let feed: Feed
}

struct Feed : Decodable {
    let results: [Results]
}

struct Results: Decodable, Hashable {
    let name: String
    let copyright: String?
    let artworkUrl100: String
    let releaseDate: String
}
