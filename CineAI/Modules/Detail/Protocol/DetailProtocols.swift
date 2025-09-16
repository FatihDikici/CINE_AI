//
//  DetailProtocols.swift
//  CineAI
//
//  Created by MB-BTMC001 on 29.08.2025.
//

import Foundation
import UIKit

protocol DetailViewProtocol:AnyObject{
    
    func showloading()
    func hideLoading()
    func showMovieDetail(movie:Movie)
    func displayRecommendation(text: String)
}

protocol DetailPresenterProtocol:AnyObject{
    
    func viewDidLoad()
    func getMovieRecommendations()
}

protocol DetailInteractorProtocol:AnyObject{
    func fetchRecommendations(for title: String)
}

protocol DetailInteractorOutputProtocol:AnyObject{
    func didFetchRecommendationsSuccess(recommendations: String)
    func didFetchRecommendationsFail(error: Error)
}

protocol DetailRouterProtocol:AnyObject{
    
    static func createModule(with movie: Movie) -> UIViewController
}
