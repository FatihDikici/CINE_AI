//
//  ChangeNameRouter.swift
//  CineAI
//
//  Created by MB-BTMC001 on 11.09.2025.
//

import Foundation
import UIKit

class ChangeNameRouter: ChangeNameRouterProtocol{
    
    weak var viewController: UIViewController?
    weak var delegate: ChangeUsernameDelegate?
    
    
    static func createModule(currentUsername:String, delegate: ChangeUsernameDelegate) -> UIViewController{
        
        let view = ChangeNameViewController()
        let presenter = ChangeNamePresenter()
        let authService = AuthService()
        let interactor = ChangeNameInteractor(authService: authService)
        let router = ChangeNameRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        presenter.CurrentName = currentUsername
        interactor.output = presenter
        router.viewController = view
        router.delegate = delegate
        view.delegate = delegate
        
        return view
    }
    
    func navigateBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
