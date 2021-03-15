//
//  MDTarget.swift
//  MVVMMovieDatabaseAppl
//
//  Created by Murat Can on 12.03.2021.
//

import Foundation
import Moya

enum MDService {
    case movie_top_rated
    case movie_popular
    case tv_top_rated
    case tv_popular
    case movieTopRatedDetail(id: Movie)
    case movieCredit(id: Movie)
    case moviePopularDetail(id: Movie)
    case tvTopRatedDetail(id: Tv)
    case tvCredit(id: Tv)
}

extension MDService: TargetType {
    var baseURL: URL {
        guard let url = Constans.baseURL else { fatalError("Error configured base url.")}
        return url
    }
    
    var path: String {
        switch self {
        case .movie_top_rated:
            return "/movie/top_rated"
        case .movie_popular:
            return "/movie/popular"
        case .tv_top_rated:
            return "/tv/top_rated"
        case .tv_popular:
            return "/tv/popular"
        case .movieTopRatedDetail(let movie):
            return "/movie/\(movie.id)"
        case .movieCredit(let movie):
            return "/movie/\(movie.id)/credits"
        case .moviePopularDetail(let movie):
            return "/movie/\(movie.id)"
        case .tvTopRatedDetail(let tv):
            return "/tv/\(tv.id)"
        case .tvCredit(let tv):
            return "/tv/\(tv.id)/credits"
        }
        
    }
    var method: Moya.Method {
        switch self {
        case .movie_top_rated:
            return .get
        case .movie_popular:
            return .get
        case .tv_top_rated:
            return .get
        case .tv_popular:
            return .get
        case .movieTopRatedDetail:
            return .get
        case .movieCredit:
            return .get
        case .moviePopularDetail:
            return .get
        case .tvTopRatedDetail:
            return .get
        case .tvCredit:
            return .get
        }
    }
    
    var sampleData: Data { return Data()}
    
    var task: Task {
        switch self {
        case .movie_top_rated:
            return .requestParameters(parameters: ["api_key" : Constans.apiKey], encoding: URLEncoding.queryString)
        case .movie_popular:
            return .requestParameters(parameters: ["api_key" : Constans.apiKey], encoding: URLEncoding.queryString)
        case .tv_top_rated:
            return .requestParameters(parameters: ["api_key" : Constans.apiKey], encoding: URLEncoding.queryString)
        case .tv_popular:
            return .requestParameters(parameters: ["api_key" : Constans.apiKey], encoding: URLEncoding.queryString)
        case .movieTopRatedDetail:
            return .requestParameters(parameters: ["api_key" : Constans.apiKey], encoding: URLEncoding.queryString)
        case .movieCredit:
            return .requestParameters(parameters: ["api_key" : Constans.apiKey], encoding: URLEncoding.queryString)
        case .moviePopularDetail:
            return .requestParameters(parameters: ["api_key" : Constans.apiKey], encoding: URLEncoding.queryString)
        case .tvTopRatedDetail:
            return .requestParameters(parameters: ["api_key" : Constans.apiKey], encoding: URLEncoding.queryString)
        case .tvCredit:
            return .requestParameters(parameters: ["api_key" : Constans.apiKey], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
