//
//  MainInteractor.swift
//  CineAI
//
//  Created by MB-BTMC001 on 28.08.2025.
//

import Foundation


class MainInteractor: MainInteractorProtocol{
    
    var presenter: MainInteractorOutputProtocol?
    
    let movieService: MovieServiceProtocol
    
    init (movieService: MovieServiceProtocol) {
        self.movieService = movieService
    }
    
    func getPopularMovies() {
        
        movieService.getPopulerMovies { [weak self] result in
            
            guard let self = self else {return}
            
            switch result{
                
            case .success(let movies):
                self.presenter?.didFetchMoviesSuccess(movies: movies)
            case .failure(let error):
                self.presenter?.didFetchMoviesFail(error: error)
                
            }
        }
    }
}
