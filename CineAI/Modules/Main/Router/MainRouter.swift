//
//  MainRouter.swift
//  CineAI
//
//  Created by MB-BTMC001 on 28.08.2025.
//

import Foundation

import UIKit

class MainRouter: MainRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = MainViewController()
        let router = MainRouter()
        
        // DI - MovieService'i enjekte ediyoruz
        let movieService: MovieServiceProtocol = MovieService()
        let interactor = MainInteractor(movieService: movieService)
        
        let presenter = MainPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        // UINavigationController içinde sunulacak
        return UINavigationController(rootViewController: view)
    }
    
    func navigateToDetailScreen(with movie: Movie) {
        
        let detailViewController = DetailRouter.createModule(with: movie)
        
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
        
    }
}
