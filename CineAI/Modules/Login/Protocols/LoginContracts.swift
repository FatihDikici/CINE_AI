//
//  LoginContracts.swift
//  CineAI
//
//  Created by MB-BTMC001 on 27.08.2025.
//

import Foundation


protocol LoginViewProtocol:AnyObject{
 
    func showLoading()
    func hideLoading()
    func showLoginError(message: String)
    func navigateToMainScreen()
}

protocol LoginPresenterProtocol: AnyObject{
    
    func loginButtonTapped(email:String?, password:String?)
    func registerButtonTapped()
    func viewDidLoad()
    
}
protocol LoginInteractorProtocol{
    func login(email: String, password: String)
    
}

protocol LoginInteractorOutputProtocol: AnyObject {
    func didLoginSuccess()
    func didLoginFail(error: Error)
}

protocol LoginRouterProtocol{
    func navigateToRegisterScreen()
    func navigateToMainScreen()
    
}
