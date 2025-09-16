//
//  ChangeNameInteractor.swift
//  CineAI
//
//  Created by MB-BTMC001 on 11.09.2025.
//

import Foundation


class ChangeNameInteractor: ChangeNameInteractorProtocol{
    
    weak var output: ChangeNameInteractorOutputProtocol?
    var authService: AuthServiceProtocol
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    func updateUserName(newUserName: String) {
        authService.updateUsername(newUsername: newUserName) { [weak self] result in
            switch result {
            case .success():
                self?.output?.userNameUpdateSuccess()
            case .failure(let error):
                self?.output?.userNameUpdateFailed(error: error)
            }
        }
    }
}
