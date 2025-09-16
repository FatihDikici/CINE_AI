//
//  ChangeNameProtocol.swift
//  CineAI
//
//  Created by MB-BTMC001 on 11.09.2025.
//

import Foundation


protocol ChangeUsernameDelegate:AnyObject{
    func didChangeUsername(newUserName:String)
}

protocol ChangeNameViewProtocol:AnyObject{
    func showLoading()
    func hideLoading()
    func displayError(message:String)
    func navigateBackToSettings()
}
protocol ChangeNamePresenterProtocol:AnyObject{
    func viewDidLoad()
    func didTapSvaeButton(newUserName:String)
    func didTapBackButton()
    var CurrentName: String? {get set}
}
protocol ChangeNameInteractorProtocol:AnyObject{
    func updateUserName(newUserName:String)
}

protocol ChangeNameInteractorOutputProtocol:AnyObject{
    func userNameUpdateSuccess()
    func userNameUpdateFailed(error: Error)
}

protocol ChangeNameRouterProtocol:AnyObject{
    func navigateBack()
    var delegate:ChangeUsernameDelegate? {get set}
}
