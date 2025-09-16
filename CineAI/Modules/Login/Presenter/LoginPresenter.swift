//
//  LoginPresenter.swift
//  CineAI
//
//  Created by MB-BTMC001 on 27.08.2025.
//

import Foundation

class LoginPresenter: LoginPresenterProtocol{
    
    weak var view: LoginViewProtocol?
    let interactor: LoginInteractorProtocol
    let router: LoginRouterProtocol
    
    init(view: LoginViewProtocol, interactor: LoginInteractorProtocol, router: LoginRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func loginButtonTapped(email: String?, password: String?) {
        guard let email = email , !email.isEmpty, let password = password, !password.isEmpty else {
            self.view?.showLoginError(message: "email veya şifre gir")
            return
        }
        view?.showLoading()
        interactor.login(email: email, password: password)
     }
    
    func registerButtonTapped() {
        router.navigateToRegisterScreen()
    }
    
    func viewDidLoad() {
        //
    }
}


extension LoginPresenter: LoginInteractorOutputProtocol{
   
    func didLoginSuccess() {
        
        self.view?.hideLoading()
        self.router.navigateToMainScreen()
    }
    
    func didLoginFail(error: Error) {
        self.view?.hideLoading()
        self.view?.showLoginError(message: error.localizedDescription)
    }
}
