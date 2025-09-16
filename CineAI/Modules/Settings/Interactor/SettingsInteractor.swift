//
//  SettingsInteractor.swift
//  CineAI
//
//  Created by MB-BTMC001 on 1.09.2025.
//

import Foundation

class SettingsInteractor: SettingInteractorProtocol{

    weak var output: SettingInteractorOutputProtocol?
    let userDefaults = UserDefaults.standard
    
    func getSavedTheme() -> Bool {
        return userDefaults.bool(forKey: "isDarkTheme")
    }
    
    func saveTheme(isDark: Bool) {
        userDefaults.set(isDark, forKey: "isDarkTheme")
    }
    
    func savePassword(_ newPassword: String) {
        print("Şifre başarıyla değiştirildi: \(newPassword)")
    }
    
    func fetchCurrentUsername() {
        let currentUsername = userDefaults.string(forKey: "currentUsername") ?? "GuestUser"
        output?.didFetchCurrentUsername(username: currentUsername)
    }
}
