

    import Foundation



    class DetailPresenter: DetailPresenterProtocol, DetailInteractorOutputProtocol {
        weak var view: (any DetailViewProtocol)?
        var interactor: any DetailInteractorProtocol
        var router: any DetailRouterProtocol
        let movie: Movie

        init(view: any DetailViewProtocol,
             interactor: any DetailInteractorProtocol,
             router: any DetailRouterProtocol,
             movie: Movie) {
            self.view = view
            self.interactor = interactor
            self.router = router
            self.movie = movie
        }

        func viewDidLoad() {
            view?.showMovieDetail(movie: movie)
        }

        func getMovieRecommendations() {
            view?.showloading()
            interactor.fetchRecommendations(for: movie.title ?? movie.name ?? "")
        }
        
        func didFetchRecommendationsSuccess(recommendations: String) {
         
            view?.hideLoading()
            view?.displayRecommendation(text: recommendations)
            
        }
        
        func didFetchRecommendationsFail(error: Error) {
            
            view?.hideLoading()
            view?.displayRecommendation(text: "Öneri alınamadı: \(error.localizedDescription)")
        }
    }

