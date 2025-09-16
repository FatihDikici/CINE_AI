//
//  LoginInteractor.swift
//  CineAI
//
//  Created by MB-BTMC001 on 27.08.2025.
//

import Foundation


class LoginInteractor: LoginInteractorProtocol{

    weak var presenter: LoginInteractorOutputProtocol?
    
    var authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    
    func login(email: String, password: String) {
        
        let credentials = LoginCredentials(email: email, password: password)
        
        authService.login(with: credentials) { [weak self] result in
            guard let self = self else { return }
            
            switch result{
                
            case .success:
                self.presenter?.didLoginSuccess()
            case .failure(let error):
                self.presenter?.didLoginFail(error: error)
            }
        }
    }
}
