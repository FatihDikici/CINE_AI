//
//  MainProtocols.swift
//  CineAI
//
//  Created by MB-BTMC001 on 28.08.2025.
//

import Foundation


protocol MainViewProtocol:AnyObject{
    func showLoading()
    func hideLoading()
    func reloadCollectionView()
    func displayMovies(movies: [Movie])
    func showErrorMessage(_ message: String)
}

protocol MainPresenterProtocol:AnyObject{
    
    func viewDidLoad()
    func getMoviesCount()->Int
    func getMovie(at index: Int) -> Movie?
    func didSelectMovie(at index: Int)
    
}

protocol MainInteractorProtocol:AnyObject{
    
    func getPopularMovies()
}

protocol MainInteractorOutputProtocol: AnyObject {
    func didFetchMoviesSuccess(movies: [Movie])
    func didFetchMoviesFail(error: Error)
}

protocol MainRouterProtocol:AnyObject{
 
    func navigateToDetailScreen(with movie: Movie)
}

