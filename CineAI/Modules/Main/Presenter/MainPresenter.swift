//
//  MainPresenter.swift
//  CineAI
//
//  Created by MB-BTMC001 on 28.08.2025.
//

import Foundation

class MainPresenter: MainPresenterProtocol{
    
    
    
    weak var view: MainViewProtocol?
    var interactor: MainInteractorProtocol
    var router: MainRouterProtocol
    
    var movies:[Movie] = []
    
    
    init(view: MainViewProtocol, interactor: MainInteractorProtocol, router: MainRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view?.showLoading()
        interactor.getPopularMovies()
    }
    
    func getMoviesCount() -> Int {
        
        return movies.count
    }
    func getMovie(at index: Int) -> Movie? {
        
        guard index < movies.count else {return nil}
        return movies[index]
    }
    
    func didSelectMovie(at index: Int) {
        if let movie = getMovie(at: index){
            router.navigateToDetailScreen(with: movie)
        }
    }
}
extension MainPresenter: MainInteractorOutputProtocol{
    
    func didFetchMoviesSuccess(movies: [Movie]) {
        
        self.movies = movies
        view?.hideLoading()
        view?.reloadCollectionView()
    }
    
    func didFetchMoviesFail(error: Error) {
        
        view?.hideLoading()
        view?.showErrorMessage(error.localizedDescription)
    }
}
