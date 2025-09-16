//
//  RegisterContracts.swift
//  CineAI
//
//  Created by MB-BTMC001 on 27.08.2025.
//

import Foundation


protocol RegisterViewProtocol:AnyObject{
    
    func showLoading()
    func hideLoading()
    func showRegisterError(_ message:String)
    func navigateToMainScreen()
    
}

protocol RegisterPresenterProtocol:AnyObject{
    
    func registerButtonTapped(email: String?,password: String?)
    func viewDidLoad()
    
}

protocol RegisterInteractorProtocol:AnyObject{
    
    func register(email:String, password: String)
    
}
protocol RegisterInteractorOutputProtocol:AnyObject{
    
    func didRegisterSuccess()
    func didRegisterFail(error: Error)
}
protocol RegisterRouterProtocol:AnyObject{
    
    func navigateToMainScreen()
}
