//
//  SettingsRouter.swift
//  CineAI
//
//  Created by MB-BTMC001 on 1.09.2025.
//

import Foundation
import UIKit

class SettingsRouter: SettingRouterProtocol{
    
    weak var viewController: UIViewController?
    
    static func CreateModule() -> UIViewController {
        
        let view = SettingsViewController()
        let interactor = SettingsInteractor()
        let router = SettingsRouter()
               
        let presenter = SettingsPresenter(view: view, interactor: interactor, router: router)
               
        view.presenter = presenter
        router.viewController = view 
               
        return view
    }
    
    func navigateToChangeUsername(currentUsername: String, delegate: ChangeUsernameDelegate) {
        let changeUsernameVC = ChangeNameRouter.createModule(currentUsername: currentUsername, delegate: delegate)
        viewController?.navigationController?.pushViewController(changeUsernameVC, animated: true)
    }
}
