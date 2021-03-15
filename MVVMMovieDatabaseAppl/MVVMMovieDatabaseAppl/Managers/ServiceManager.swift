//
//  ServiceManager.swift
//  MVVMMovieDatabaseAppl
//
//  Created by Murat Can on 12.03.2021.
//

import Foundation
import Moya




class ServieManager {
    static let shared = ServieManager()
    var provider = MoyaProvider<MDService>(plugins: [NetworkLoggerPlugin()])

    private init () {}
    
    //MARK: - Movie Top Rated Request
    func getMovieTopRated(completion: @escaping (Result<MovieResponse?, Error>) -> ()) {
        provider.request(.movie_top_rated) { (response) in
            switch response {
            case.failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(MovieResponse.self, from: value.data)
                    completion(.success(result))
                } catch let error{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    //MARK: - Movie Popular Request
    
    func getMoviePopular(completion: @escaping (Result<MovieResponse?,Error>) -> ()) {
        provider.request(.movie_popular) { (response) in
            switch response {
            case.failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(MovieResponse.self, from: value.data)
                    completion(.success(result))
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    //MARK: - Tv Top Rated Request
    func getTvTopRated(completion: @escaping (Result<TVResponse?, Error>) -> ()) {
        provider.request(.tv_top_rated) { response in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(TVResponse.self, from: value.data)
                    completion(.success(result))
                } catch let error{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    //MARK: - Tv Popular Request
    func getTvPopular(completion: @escaping (Result<TVResponse?, Error>) -> ()) {
        provider.request(.tv_popular) { response in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(TVResponse.self, from: value.data)
                    completion(.success(result))
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    //MARK: - Movie Top Rated Detail Request
    func getMovieTopRatedDetail(for movie: Movie, completion: @escaping (Result<Movie?, Error>) -> ()) {
        provider.request(.movieTopRatedDetail(id: movie)) { response in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(Movie.self, from: value.data)
                    completion(.success(result))
                    
                } catch let error {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }
    }
    
    //MARK: - Movie Credit/Cast Request
    
    func getMovieCredit(for movie: Movie, completion: @escaping (Result<CreditsResponse,Error>) -> ()) {
        provider.request(.movieCredit(id: movie)) { response in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(CreditsResponse.self, from: value.data)
                    completion(.success(result))
                } catch let error {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }
    }
    
    //MARK: - Movie Popular Detail
    func getMoviePopularDetail(for movie: Movie, completion: @escaping (Result<Movie?, Error>) ->()) {
        provider.request(.moviePopularDetail(id: movie)) { (response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(Movie.self, from: value.data)
                    completion(.success(result))
                } catch let error {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }
    }
    
    //MARK: - Tv Top Rated Detail
    func getTvTopRatedDetail(for tv: Tv, completion: @escaping (Result<Tv?, Error>) -> ()) {
        provider.request(.tvTopRatedDetail(id: tv)) { (response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(Tv.self, from: value.data)
                    completion(.success(result))
                } catch let error {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }
    }
    
    //MARK: - Tv Popular Detail
    func getTvPopularDetail(for tv: Tv, completion: @escaping (Result<Tv?, Error>) -> ()) {
        provider.request(.tvTopRatedDetail(id: tv)) { (response) in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(Tv.self, from: value.data)
                    completion(.success(result))
                } catch let error {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }
    }
    
    //MARK: - TV Credit/Cast Request
    func getTVCredit(for tv: Tv, completion: @escaping (Result<CreditsResponse,Error>) -> ()) {
        provider.request(.tvCredit(id: tv)) { response in
            switch response {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let value):
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(CreditsResponse.self, from: value.data)
                    completion(.success(result))
                } catch let error {
                    print(error.localizedDescription)
                    completion(.failure(error))
                }
            }
        }
    }
}
