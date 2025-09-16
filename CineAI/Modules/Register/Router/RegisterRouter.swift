//
//  RegisterRouter.swift
//  CineAI
//
//  Created by MB-BTMC001 on 27.08.2025.
//

import Foundation

import UIKit

class RegisterRouter: RegisterRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = RegisterViewController()
        let router = RegisterRouter()
        let authService: AuthServiceProtocol = AuthService()
        let interactor = RegisterInteractor(authService: authService)
        
        let presenter = RegisterPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func navigateToMainScreen() {
        let mainViewController = MainRouter.createModule()
        
        // Kayıt ekranından ana ekrana geçiş yaparken mevcut ekranı kapatıyoruz.
        // Bu, kullanıcı kayıt olduğunda geri tuşuna basıp tekrar kayıt ekranına dönmesini engeller.
        viewController?.dismiss(animated: true, completion: {
            guard let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
            window.rootViewController = mainViewController
            window.makeKeyAndVisible()
        })
    }
}
