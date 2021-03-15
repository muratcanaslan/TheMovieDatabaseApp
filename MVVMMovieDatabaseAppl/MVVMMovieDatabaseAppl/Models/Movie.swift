//
//  MovieTopRatedResponse.swift
//  MVVMMovieDatabaseAppl
//
//  Created by Murat Can on 12.03.2021.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let posterPath: URL?
    let backdrop: URL?
    let title: String?
    let releaseDate: String?
    let rating: Double?
    let overview: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case backdrop = "backdrop_path"
        case title
        case releaseDate = "release_date"
        case rating = "vote_average"
        case overview
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let baseImageUrlString = "https://image.tmdb.org/t/p/w500"
        let backdropPathUrlString = try container.decode(String.self, forKey: .backdrop)
        let posterPathUrlString = try container.decode(String.self, forKey: .posterPath)
        self.id = try container.decode(Int.self, forKey: .id)
        self.posterPath = URL(string: baseImageUrlString + (posterPathUrlString ))
        self.backdrop = URL(string: baseImageUrlString + (backdropPathUrlString ))
        self.title = try container.decode(String.self, forKey: .title)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.rating = try container.decode(Double.self, forKey: .rating)
        self.overview = try container.decode(String.self, forKey: .overview)
    }
}

struct MovieResponse: Codable {
    let results : [Movie]?
}

struct TVResponse: Codable {
    let results: [Tv]?
}
