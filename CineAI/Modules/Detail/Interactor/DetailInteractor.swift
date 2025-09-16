//
//  DetailInteractor.swift
//  CineAI
//
//  Created by MB-BTMC001 on 29.08.2025.
//

import Foundation


class DetailInteractor: DetailInteractorProtocol{
    
    weak var presenter: (any DetailInteractorOutputProtocol)?
    
    var aiService: AIServiceProtocol
    
    init(aiService: AIServiceProtocol){
        self.aiService = aiService
    }
    
    func fetchRecommendations(for title: String) {
        
        aiService.getSimilarMovies(title: title) { [weak self] result in
            switch result {
                
            case .success(let recommendations):
                self?.presenter?.didFetchRecommendationsSuccess(recommendations: recommendations )
                
            case .failure(let error):
                self?.presenter?.didFetchRecommendationsFail(error: error)
            }
        }
    }
}
