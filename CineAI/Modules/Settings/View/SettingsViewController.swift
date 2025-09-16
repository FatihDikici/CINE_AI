//
//  SettingsViewController.swift
//  CineAI
//
//  Created by MB-BTMC001 on 1.09.2025.
//

import UIKit


class SettingsViewController: UIViewController {

    var presenter: SettingPresenterProtocol?
    
    let themeSwitch = UISwitch()
    let backgroundView = UIView()
    
    // Modern container views
    private let accountContainerView = UIView()
    private let generalContainerView = UIView()
    private let aboutContainerView = UIView()
    
    // UI Elements
    private let titleLabel = UILabel()
    private let accountSectionLabel = UILabel()
    private let generalSectionLabel = UILabel()
    private let aboutSectionLabel = UILabel()
    private let usernameLabel = UILabel() // Add usernameLabel
    
    // Account buttons
    private let changeUsernameButton = UIButton(type: .system)
    private let changePasswordButton = UIButton(type: .system)
    
    // Theme container
    private let themeContainerView = UIView()
    private let themeLabel = UILabel()
    
    // About elements
    private let appVersionLabel = UILabel()
    private let developerLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAnimations()
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateEntrance()
        
        // Gradient'i doğru boyutta ayarlama
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.updateGradientFrame()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateGradientFrame()
    }
    
    func setupUI() {
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.1, alpha: 1.0)
        
        // Modern gradient background
        setupGradientBackground()
        
        // Navigation bar styling
        setupNavigationBar()
        
        // Main title
        setupTitleLabel()
        
        // Container setup
        setupContainers()
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        view.addSubview(scrollView)
        
        let contentStackView = UIStackView(arrangedSubviews: [
            titleLabel,
            accountContainerView,
            generalContainerView,
            aboutContainerView
        ])
        contentStackView.axis = .vertical
        contentStackView.spacing = 25
        contentStackView.alignment = .fill
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStackView)
        
        // Constraints
        NSLayoutConstraint.activate([
            // ScrollView
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // Content Stack
            contentStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor, constant: -20),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: -20),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor, constant: -40),
            
            // Title height
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            
            // Container heights
            accountContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 140),
            generalContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 80),
            aboutContainerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ])
    }
    
    func setupGradientBackground() {
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor(red: 0.80, green: 0.12, blue: 0.25, alpha: 1.0).cgColor,
            UIColor(red: 0.15, green: 0.08, blue: 0.20, alpha: 1.0).cgColor,
            UIColor(red: 0.05, green: 0.05, blue: 0.15, alpha: 1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.locations = [0.0, 0.5, 1.0]
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupNavigationBar() {
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.0)
        
        
        navigationItem.title = ""
    }
    
    func setupTitleLabel() {
        titleLabel.text = "⚙️ Ayarlar"
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupContainers() {
        // Account Container
        setupAccountContainer()
        
        // General Container
        setupGeneralContainer()
        
        // About Container
        setupAboutContainer()
    }
    
    func setupAccountContainer() {
        accountContainerView.translatesAutoresizingMaskIntoConstraints = false
        accountContainerView.backgroundColor = UIColor(white: 1.0, alpha: 0.08)
        accountContainerView.layer.cornerRadius = 20
        accountContainerView.layer.borderWidth = 1
        accountContainerView.layer.borderColor = UIColor(white: 1.0, alpha: 0.15).cgColor
        
        // Glassmorphism effect
        accountContainerView.layer.shadowColor = UIColor.black.cgColor
        accountContainerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        accountContainerView.layer.shadowRadius = 15
        accountContainerView.layer.shadowOpacity = 0.2
        
        // Section label
        accountSectionLabel.text = "👤 Hesap Ayarları"
        accountSectionLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        accountSectionLabel.textColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.0)
        accountSectionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Username Label setup
        usernameLabel.font = .systemFont(ofSize: 16, weight: .medium)
        usernameLabel.textColor = .white
        usernameLabel.textAlignment = .left
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Username button
        changeUsernameButton.setTitle("📝 Kullanıcı Adını Değiştir", for: .normal)
        changeUsernameButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        changeUsernameButton.setTitleColor(.white, for: .normal)
        changeUsernameButton.backgroundColor = UIColor(white: 1.0, alpha: 0.1)
        changeUsernameButton.layer.cornerRadius = 12
        changeUsernameButton.layer.borderWidth = 1
        changeUsernameButton.layer.borderColor = UIColor(white: 1.0, alpha: 0.2).cgColor
        changeUsernameButton.translatesAutoresizingMaskIntoConstraints = false
        changeUsernameButton.addTarget(self, action: #selector(changeUsernameButtonTapped), for: .touchUpInside)
        
        // Password button
        changePasswordButton.setTitle("🔐 Şifreyi Değiştir", for: .normal)
        changePasswordButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        changePasswordButton.setTitleColor(.white, for: .normal)
        changePasswordButton.backgroundColor = UIColor(white: 1.0, alpha: 0.1)
        changePasswordButton.layer.cornerRadius = 12
        changePasswordButton.layer.borderWidth = 1
        changePasswordButton.layer.borderColor = UIColor(white: 1.0, alpha: 0.2).cgColor
        changePasswordButton.translatesAutoresizingMaskIntoConstraints = false
        changePasswordButton.addTarget(self, action: #selector(changePasswordButtonTapped), for: .touchUpInside)
        
        // Add button animations
        setupButtonAnimations(for: changeUsernameButton)
        setupButtonAnimations(for: changePasswordButton)
        
        let accountStack = UIStackView(arrangedSubviews: [
            accountSectionLabel,
            usernameLabel,
            changeUsernameButton,
            changePasswordButton
        ])
        accountStack.axis = .vertical
        accountStack.spacing = 15
        accountStack.alignment = .fill
        accountStack.translatesAutoresizingMaskIntoConstraints = false
        
        accountContainerView.addSubview(accountStack)
        
        NSLayoutConstraint.activate([
            usernameLabel.heightAnchor.constraint(equalToConstant: 25),
            changeUsernameButton.heightAnchor.constraint(equalToConstant: 44),
            changePasswordButton.heightAnchor.constraint(equalToConstant: 44),
            
            accountStack.topAnchor.constraint(equalTo: accountContainerView.topAnchor, constant: 20),
            accountStack.leadingAnchor.constraint(equalTo: accountContainerView.leadingAnchor, constant: 20),
            accountStack.trailingAnchor.constraint(equalTo: accountContainerView.trailingAnchor, constant: -20),
            accountStack.bottomAnchor.constraint(equalTo: accountContainerView.bottomAnchor, constant: -20)
        ])
    }
    
    func setupGeneralContainer() {
        generalContainerView.translatesAutoresizingMaskIntoConstraints = false
        generalContainerView.backgroundColor = UIColor(white: 1.0, alpha: 0.06)
        generalContainerView.layer.cornerRadius = 20
        generalContainerView.layer.borderWidth = 1
        generalContainerView.layer.borderColor = UIColor(white: 1.0, alpha: 0.12).cgColor
        
        // Glassmorphism effect
        generalContainerView.layer.shadowColor = UIColor.black.cgColor
        generalContainerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        generalContainerView.layer.shadowRadius = 12
        generalContainerView.layer.shadowOpacity = 0.15
        
        // Section label
        generalSectionLabel.text = "🎨 Genel Ayarlar"
        generalSectionLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        generalSectionLabel.textColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.0)
        generalSectionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Theme container
        themeContainerView.backgroundColor = UIColor(white: 1.0, alpha: 0.1)
        themeContainerView.layer.cornerRadius = 12
        themeContainerView.layer.borderWidth = 1
        themeContainerView.layer.borderColor = UIColor(white: 1.0, alpha: 0.2).cgColor
        themeContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Theme label
        themeLabel.text = "🌙 Karanlık Tema"
        themeLabel.font = .systemFont(ofSize: 16, weight: .medium)
        themeLabel.textColor = .white
        themeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Theme switch styling
        themeSwitch.onTintColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.0)
        themeSwitch.thumbTintColor = .white
        themeSwitch.translatesAutoresizingMaskIntoConstraints = false
        themeSwitch.addTarget(self, action: #selector(themeSwitchChanged), for: .valueChanged)
        
        themeContainerView.addSubview(themeLabel)
        themeContainerView.addSubview(themeSwitch)
        
        let generalStack = UIStackView(arrangedSubviews: [
            generalSectionLabel,
            themeContainerView
        ])
        generalStack.axis = .vertical
        generalStack.spacing = 15
        generalStack.alignment = .fill
        generalStack.translatesAutoresizingMaskIntoConstraints = false
        
        generalContainerView.addSubview(generalStack)
        
        NSLayoutConstraint.activate([
            // Theme container constraints
            themeContainerView.heightAnchor.constraint(equalToConstant: 50),
            themeLabel.leadingAnchor.constraint(equalTo: themeContainerView.leadingAnchor, constant: 15),
            themeLabel.centerYAnchor.constraint(equalTo: themeContainerView.centerYAnchor),
            themeSwitch.trailingAnchor.constraint(equalTo: themeContainerView.trailingAnchor, constant: -15),
            themeSwitch.centerYAnchor.constraint(equalTo: themeContainerView.centerYAnchor),
            
            // General stack constraints
            generalStack.topAnchor.constraint(equalTo: generalContainerView.topAnchor, constant: 20),
            generalStack.leadingAnchor.constraint(equalTo: generalContainerView.leadingAnchor, constant: 20),
            generalStack.trailingAnchor.constraint(equalTo: generalContainerView.trailingAnchor, constant: -20),
            generalStack.bottomAnchor.constraint(equalTo: generalContainerView.bottomAnchor, constant: -20)
        ])
    }
    
    func setupAboutContainer() {
        aboutContainerView.translatesAutoresizingMaskIntoConstraints = false
        aboutContainerView.backgroundColor = UIColor(white: 1.0, alpha: 0.05)
        aboutContainerView.layer.cornerRadius = 20
        aboutContainerView.layer.borderWidth = 1
        aboutContainerView.layer.borderColor = UIColor(white: 1.0, alpha: 0.1).cgColor
        
        // Glassmorphism effect
        aboutContainerView.layer.shadowColor = UIColor.black.cgColor
        aboutContainerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        aboutContainerView.layer.shadowRadius = 10
        aboutContainerView.layer.shadowOpacity = 0.1
        
        // Section label
        aboutSectionLabel.text = "ℹ️ Uygulama Hakkında"
        aboutSectionLabel.font = .systemFont(ofSize: 18, weight: .semibold)
        aboutSectionLabel.textColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.0)
        aboutSectionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // App version
        appVersionLabel.text = "📱 Versiyon: 1.0.0"
        appVersionLabel.font = .systemFont(ofSize: 15, weight: .regular)
        appVersionLabel.textColor = UIColor(white: 0.85, alpha: 1.0)
        appVersionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let aboutStack = UIStackView(arrangedSubviews: [
            aboutSectionLabel,
            appVersionLabel,
            developerLabel
        ])
        aboutStack.axis = .vertical
        aboutStack.spacing = 12
        aboutStack.alignment = .fill
        aboutStack.translatesAutoresizingMaskIntoConstraints = false
        
        aboutContainerView.addSubview(aboutStack)
        
        NSLayoutConstraint.activate([
            aboutStack.topAnchor.constraint(equalTo: aboutContainerView.topAnchor, constant: 20),
            aboutStack.leadingAnchor.constraint(equalTo: aboutContainerView.leadingAnchor, constant: 20),
            aboutStack.trailingAnchor.constraint(equalTo: aboutContainerView.trailingAnchor, constant: -20),
            aboutStack.bottomAnchor.constraint(equalTo: aboutContainerView.bottomAnchor, constant: -20)
        ])
    }
    
    func setupButtonAnimations(for button: UIButton) {
        button.addTarget(self, action: #selector(buttonTouchDown(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(buttonTouchUp(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    func setupAnimations() {
        // Initial animation state
        titleLabel.transform = CGAffineTransform(translationX: 0, y: -30)
        titleLabel.alpha = 0
        
        accountContainerView.transform = CGAffineTransform(translationX: -40, y: 0)
        accountContainerView.alpha = 0
        
        generalContainerView.transform = CGAffineTransform(translationX: 40, y: 0)
        generalContainerView.alpha = 0
        
        aboutContainerView.transform = CGAffineTransform(translationX: 0, y: 30)
        aboutContainerView.alpha = 0
    }
    
    func animateEntrance() {
        // Title animation
        UIView.animate(withDuration: 0.6, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3) {
            self.titleLabel.alpha = 1
            self.titleLabel.transform = .identity
        }
        
        // Account container animation
        UIView.animate(withDuration: 0.7, delay: 0.2, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4) {
            self.accountContainerView.alpha = 1
            self.accountContainerView.transform = .identity
        }
        
        // General container animation
        UIView.animate(withDuration: 0.7, delay: 0.3, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.4) {
            self.generalContainerView.alpha = 1
            self.generalContainerView.transform = .identity
        }
        
        // About container animation
        UIView.animate(withDuration: 0.6, delay: 0.4, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3) {
            self.aboutContainerView.alpha = 1
            self.aboutContainerView.transform = .identity
        }
    }
    
    func updateGradientFrame() {
        if let gradientLayer = backgroundView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = view.bounds
        }
    }
    
    // MARK: - Button Actions
    @objc func buttonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            sender.backgroundColor = UIColor(white: 1.0, alpha: 0.05)
        }
    }
    
    @objc func buttonTouchUp(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
            sender.backgroundColor = UIColor(white: 1.0, alpha: 0.1)
        }
    }
    
    @objc func changeUsernameButtonTapped() {
        // Button'a tıklama animasyonu
        UIView.animate(withDuration: 0.2, animations: {
            self.changeUsernameButton.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.changeUsernameButton.transform = .identity
            }
        }
        
        presenter?.didTapChangeUsername()
    }
    
    @objc func changePasswordButtonTapped() {
        // Button'a tıklama animasyonu
        UIView.animate(withDuration: 0.2, animations: {
            self.changePasswordButton.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                self.changePasswordButton.transform = .identity
            }
        }
        
        presenter?.didTapChangePassword()
    }
    
    @objc func themeSwitchChanged() {
        // Switch animasyonu
        UIView.animate(withDuration: 0.3, animations: {
            self.themeContainerView.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.themeContainerView.transform = .identity
            }
        }
        
        presenter?.didChangeTheme(isDark: themeSwitch.isOn)
    }
}

// MARK: - SettingsViewProtocol
extension SettingsViewController: SettingsViewProtocol, ChangeUsernameDelegate {
    func displaySettings(isDarkTheme: Bool) {
        themeSwitch.isOn = isDarkTheme
    }
    
    func updateUsername(username: String) {
        usernameLabel.text = "Kullanıcı Adı: \(username)"
    }
    
    func didChangeUsername(newUserName: String) {
        updateUsername(username: newUserName)
    }
    
    func showChangePasswordAlert() {
        let alert = UIAlertController(title: "Şifreyi Değiştir", message: "Yeni şifrenizi girin", preferredStyle: .alert)
        
        // Alert'i özelleştir
        alert.view.tintColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.0)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Yeni Şifre"
            textField.isSecureTextEntry = true
            textField.borderStyle = .roundedRect
        }
        
        alert.addAction(UIAlertAction(title: "Vazgeç", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Kaydet", style: .default, handler: { [weak self] _ in
            if let newPassword = alert.textFields?.first?.text, !newPassword.isEmpty {
                // Başarı animasyonu
                self?.animateSuccess()
            }
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    private func animateSuccess() {
        UIView.animate(withDuration: 0.3, animations: {
            self.accountContainerView.backgroundColor = UIColor(red: 0.2, green: 0.8, blue: 0.2, alpha: 0.2)
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.accountContainerView.backgroundColor = UIColor(white: 1.0, alpha: 0.08)
            }
        }
    }
}
