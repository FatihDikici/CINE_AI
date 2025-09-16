//
//  DetailRouter.swift
//  CineAI
//
//  Created by MB-BTMC001 on 29.08.2025.
//

import Foundation
import UIKit

class DetailRouter: DetailRouterProtocol{
    
    weak var viewController: UIViewController?
    
    static func createModule(with movie: Movie) -> UIViewController {
        
        let aiService: AIServiceProtocol = AIService()
        let view = DetailViewController()
        let interactor = DetailInteractor(aiService: aiService)
        let router = DetailRouter()
        
        let presenter = DetailPresenter(view: view, interactor: interactor,router: router,movie: movie)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
