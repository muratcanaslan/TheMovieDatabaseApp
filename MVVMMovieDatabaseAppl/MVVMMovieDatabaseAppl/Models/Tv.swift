//
//  Tv.swift
//  MVVMMovieDatabaseAppl
//
//  Created by Murat Can on 12.03.2021.
//

import Foundation


struct Tv: Codable {
    let id: Int
    let posterPath: URL?
    let name: String?
    let releaseDate: String?
    let rating: Double?
    let overview: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case name
        case releaseDate = "first_air_date"
        case rating = "vote_average"
        case overview
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let baseImageUrlString = "https://image.tmdb.org/t/p/w500"
        let posterPathUrlString = try container.decode(String.self, forKey: .posterPath)
        self.id = try container.decode(Int.self, forKey: .id)
        self.posterPath = URL(string: baseImageUrlString + (posterPathUrlString ))
        self.name = try container.decode(String.self, forKey: .name)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.rating = try container.decode(Double.self, forKey: .rating)
        self.overview = try container.decode(String.self, forKey: .overview)
    }
}
