//
//  MovieService.swift
//  CineAI
//
//  Created by MB-BTMC001 on 28.08.2025.
//

import Foundation
import Alamofire

protocol MovieServiceProtocol{
    
    func getPopulerMovies(completion: @escaping (Result<[Movie], Error>) ->Void)
}

class MovieService: MovieServiceProtocol{
    
    let apiKey = "943194bf718229dc4514a34cd7a1d2cc"
    let baseUrl = "https://api.themoviedb.org/3"
    
    
    func getPopulerMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        let urlString = "\(baseUrl)/movie/popular"
        let parameters: [String: Any] = [
        
            "api_key":apiKey,
            "language": "tr-TR"
        ]
        
        AF.request(urlString, parameters: parameters).responseDecodable(of:MovieResponse.self) { response in
            
            switch response.result{
                
            case .success(let movieResponse):
                completion(.success(movieResponse.results))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

