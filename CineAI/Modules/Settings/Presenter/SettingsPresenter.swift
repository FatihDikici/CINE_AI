//
//  SettingsPresenter.swift
//  CineAI
//
//  Created by MB-BTMC001 on 1.09.2025.
//

import Foundation

class SettingsPresenter: SettingPresenterProtocol{
    
    weak var view: SettingsViewProtocol?
    var interactor: SettingInteractorProtocol
    var router: SettingRouterProtocol
    var currentUsername: String // Add this property
    
    init(view: SettingsViewProtocol, interactor: SettingInteractorProtocol, router: SettingRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.currentUsername = "Varsayılan Kullanıcı"
        self.interactor.output = self
    }
    
    func viewDidLoad() {
        let isDarkTheme = interactor.getSavedTheme()
        view?.displaySettings(isDarkTheme: isDarkTheme)
        interactor.fetchCurrentUsername()
    }
    
    func didChangeTheme(isDark: Bool) {
        interactor.saveTheme(isDark: isDark)
    }
    
    func didTapChangeUsername() {
        router.navigateToChangeUsername(currentUsername: currentUsername, delegate: self)
    }
    
    func didTapChangePassword() {
        view?.showChangePasswordAlert()
    }
}

extension SettingsPresenter: ChangeUsernameDelegate, SettingInteractorOutputProtocol {
    func didChangeUsername(newUserName: String) {
        self.currentUsername = newUserName
        view?.updateUsername(username: newUserName)
    }
    
    func didFetchCurrentUsername(username: String) {
        self.currentUsername = username
        view?.updateUsername(username: username)
    }
}
