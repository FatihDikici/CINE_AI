//
//  LoginRouter.swift
//  CineAI
//
//  Created by MB-BTMC001 on 27.08.2025.
//

import Foundation
import UIKit

class LoginRouter: LoginRouterProtocol{
    
    static func createModule() -> UIViewController{
    
        let view = LoginViewController()
        let router = LoginRouter()
        
        let authService: AuthServiceProtocol = AuthService()
        let interactor = LoginInteractor(authService: authService)
        
        
        let presenter = LoginPresenter(view: view, interactor: interactor, router: router)
        
        
        view.presenter = presenter
        interactor.presenter = presenter
        return view
    }
    
    func navigateToRegisterScreen() {
        
        let registerViewController = RegisterRouter.createModule()
                let navController = UINavigationController(rootViewController: registerViewController)
                // Login ekranı bir navigation controller içinde olmadığı için,
                // yeni ekranı modally (ekranın üstüne bindirilmiş şekilde) sunacağız.
                guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
                      let topViewController = window.rootViewController else {
                    return
                }
                topViewController.present(navController, animated: true, completion: nil)
    }
    
    func navigateToMainScreen() {
        let mainViewController = MainRouter.createModule()
           
           // Uygulamanın rootViewController'ını değiştiriyoruz.
           // Bu, geri dönme (back) butonu olmadan doğrudan ana ekrana geçişi sağlar.
           // Bu, kullanıcı giriş yaptığında bir daha login ekranını görmemesi için yaygın bir pratik.
           guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
           window.rootViewController = mainViewController
           window.makeKeyAndVisible()
    }
}
