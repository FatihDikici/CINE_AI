//
//  RegisterInteractor.swift
//  CineAI
//
//  Created by MB-BTMC001 on 27.08.2025.
//

import Foundation


class RegisterInteractor: RegisterInteractorProtocol{
    
    var presenter: RegisterInteractorOutputProtocol?
    
    var authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func register(email: String, password: String) {
        
        let credentials = LoginCredentials(email: email, password: password)
        
        authService.register(with: credentials) { [weak self] result in
            guard let self = self else {return}
            
            switch result{
                
            case .success:
                self.presenter?.didRegisterSuccess()
            case .failure(let error):
                self.presenter?.didRegisterFail(error: error)
            }
        }
    }
}
