//
//  SettingsProtocol.swift
//  CineAI
//
//  Created by MB-BTMC001 on 1.09.2025.
//

import Foundation
import UIKit

protocol SettingsViewProtocol:AnyObject{
    
    func displaySettings(isDarkTheme: Bool)
    func updateUsername(username: String)
    func showChangePasswordAlert()
}

protocol SettingPresenterProtocol:AnyObject{
    var currentUsername: String { get set }
    func viewDidLoad()
    func didChangeTheme(isDark:Bool)
    func didTapChangeUsername()
    func didTapChangePassword()
}

protocol SettingInteractorProtocol:AnyObject{
    
    func getSavedTheme() -> Bool
    func saveTheme(isDark: Bool)
    func savePassword(_ newPassword: String)
    func fetchCurrentUsername()
    var output: SettingInteractorOutputProtocol? { get set }
}

protocol SettingInteractorOutputProtocol:AnyObject{
        
    func didFetchCurrentUsername(username: String)
}

protocol SettingRouterProtocol:AnyObject{
    
    static func CreateModule() -> UIViewController
    func navigateToChangeUsername(currentUsername: String, delegate: ChangeUsernameDelegate)
}


