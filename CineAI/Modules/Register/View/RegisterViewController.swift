//
//  RegisterViewController.swift
//  CineAI
//
//  Created by MB-BTMC001 on 27.08.2025.
//

import UIKit

class RegisterViewController: UIViewController {

    var presenter: RegisterPresenterProtocol?
    
    // Modern tasarım elemanları
    let backgroundView = UIView()
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialDark))
    let logoImageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let emailContainerView = UIView()
    let passwordContainerView = UIView()
    let confirmPasswordContainerView = UIView()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let confirmPasswordTextField = UITextField()
    let registerButton = UIButton(type: .system)
    let loginButton = UIButton(type: .system)
    let activity = UIActivityIndicatorView(style: .large)
    let emailIconImageView = UIImageView()
    let passwordIconImageView = UIImageView()
    let confirmPasswordIconImageView = UIImageView()
    
    // Floating labels
    let emailFloatingLabel = UILabel()
    let passwordFloatingLabel = UILabel()
    let confirmPasswordFloatingLabel = UILabel()
    
    lazy var formStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailContainerView, passwordContainerView, confirmPasswordContainerView])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [registerButton, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupAnimations()
        presenter?.viewDidLoad()
    }
    
    func setupUI(){
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.1, alpha: 1.0)
        
        // Modern gradient background
        setupGradientBackground()
        
        // Main container
        let mainContainerView = UIView()
        mainContainerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mainContainerView)
        
        // Logo setup (cinema icon)
        logoImageView.image = UIImage(systemName: "person.circle.fill")
        logoImageView.tintColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.0) // Altın rengi
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Title styling
        titleLabel.text = "HESAP OLUŞTUR"
        titleLabel.font = .systemFont(ofSize: 38, weight: .black)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Subtitle ekleme
        subtitleLabel.text = "Sinema Serüveniniz Başlasın"
        subtitleLabel.font = .systemFont(ofSize: 16, weight: .light)
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = UIColor(white: 0.8, alpha: 1.0)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Modern input field containers
        setupInputContainer(containerView: emailContainerView,
                          textField: emailTextField,
                          iconImageView: emailIconImageView,
                          floatingLabel: emailFloatingLabel,
                          placeholder: "E-posta adresiniz",
                          iconName: "envelope.fill")
        
        setupInputContainer(containerView: passwordContainerView,
                          textField: passwordTextField,
                          iconImageView: passwordIconImageView,
                          floatingLabel: passwordFloatingLabel,
                          placeholder: "Şifreniz",
                          iconName: "lock.fill")
   
        
        setupInputContainer(containerView: confirmPasswordContainerView,
                          textField: confirmPasswordTextField,
                          iconImageView: confirmPasswordIconImageView,
                          floatingLabel: confirmPasswordFloatingLabel,
                          placeholder: "Şifrenizi tekrar girin",
                          iconName: "lock.circle.fill")
        
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
        
        // Modern button styling
        setupRegisterButton()
        setupSecondaryButtons()
        
        // Activity indicator
        activity.color = .white
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.hidesWhenStopped = true
        
        // Add all subviews
        mainContainerView.addSubview(logoImageView)
        mainContainerView.addSubview(titleLabel)
        mainContainerView.addSubview(subtitleLabel)
        mainContainerView.addSubview(formStackView)
        mainContainerView.addSubview(buttonStackView)
        view.addSubview(activity)
        
        // Constraints
        NSLayoutConstraint.activate([
            mainContainerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            mainContainerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            mainContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            
            logoImageView.topAnchor.constraint(equalTo: mainContainerView.topAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: mainContainerView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 80),
            logoImageView.heightAnchor.constraint(equalToConstant: 80),
            
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            
            formStackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 35),
            formStackView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            formStackView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            
            buttonStackView.topAnchor.constraint(equalTo: formStackView.bottomAnchor, constant: 30),
            buttonStackView.leadingAnchor.constraint(equalTo: mainContainerView.leadingAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: mainContainerView.trailingAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: mainContainerView.bottomAnchor),
            
            emailContainerView.heightAnchor.constraint(equalToConstant: 60),
            passwordContainerView.heightAnchor.constraint(equalToConstant: 60),
            confirmPasswordContainerView.heightAnchor.constraint(equalToConstant: 60),
            registerButton.heightAnchor.constraint(equalToConstant: 55),
            
            activity.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Actions
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        // Text field delegates for floating labels
        emailTextField.addTarget(self, action: #selector(emailTextFieldChanged), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldChanged), for: .editingChanged)
        confirmPasswordTextField.addTarget(self, action: #selector(confirmPasswordTextFieldChanged), for: .editingChanged)
        
        emailTextField.addTarget(self, action: #selector(emailTextFieldEditingBegan), for: .editingDidBegin)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldEditingBegan), for: .editingDidBegin)
        confirmPasswordTextField.addTarget(self, action: #selector(confirmPasswordTextFieldEditingBegan), for: .editingDidBegin)
        
        emailTextField.addTarget(self, action: #selector(emailTextFieldEditingEnded), for: .editingDidEnd)
        passwordTextField.addTarget(self, action: #selector(passwordTextFieldEditingEnded), for: .editingDidEnd)
        confirmPasswordTextField.addTarget(self, action: #selector(confirmPasswordTextFieldEditingEnded), for: .editingDidEnd)
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
    
    func setupInputContainer(containerView: UIView, textField: UITextField, iconImageView: UIImageView, floatingLabel: UILabel, placeholder: String, iconName: String) {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor(white: 1.0, alpha: 0.08)
        containerView.layer.cornerRadius = 15
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor(white: 1.0, alpha: 0.1).cgColor
        
        // Glassmorphism effect
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOpacity = 0.1
        
        // Icon setup
        iconImageView.image = UIImage(systemName: iconName)
        iconImageView.tintColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 0.8)
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // TextField setup
        textField.borderStyle = .none
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 16, weight: .medium)
        textField.backgroundColor = .clear
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        // Floating label setup
        floatingLabel.text = placeholder
        floatingLabel.font = .systemFont(ofSize: 12, weight: .medium)
        floatingLabel.textColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 0.8)
        floatingLabel.alpha = 0
        floatingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(iconImageView)
        containerView.addSubview(textField)
        containerView.addSubview(floatingLabel)
        
        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            textField.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15),
            textField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 25),
            
            floatingLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            floatingLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -5)
        ])
        
        // Placeholder styling
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 0.7, alpha: 0.6)]
        )
    }
    
    func setupRegisterButton() {
        registerButton.setTitle("HESAP OLUŞTUR", for: .normal)
        registerButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Gradient button background - Yeşil tonlarda register için
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 0.2, green: 0.8, blue: 0.4, alpha: 1.0).cgColor,
            UIColor(red: 0.1, green: 0.6, blue: 0.3, alpha: 1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.cornerRadius = 27.5
        
        registerButton.layer.insertSublayer(gradientLayer, at: 0)
        registerButton.layer.cornerRadius = 27.5
        
        // Modern shadow - Yeşil glow
        registerButton.layer.shadowColor = UIColor(red: 0.2, green: 0.8, blue: 0.4, alpha: 0.4).cgColor
        registerButton.layer.shadowOffset = CGSize(width: 0, height: 8)
        registerButton.layer.shadowRadius = 20
        registerButton.layer.shadowOpacity = 0.6
        
        // Button'a press animasyonu eklemek için
        registerButton.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchDown)
        registerButton.addTarget(self, action: #selector(buttonReleased(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
    }
    
    func setupSecondaryButtons() {
        // Login button with modern styling
        loginButton.setTitle("Zaten hesabın var mı? Giriş Yap", for: .normal)
        loginButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = UIColor(white: 1.0, alpha: 0.08)
        loginButton.layer.cornerRadius = 27.5
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor(white: 1.0, alpha: 0.2).cgColor
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Login button height
        loginButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    func setupAnimations() {
        // Initial animation state
        logoImageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        titleLabel.transform = CGAffineTransform(translationX: 0, y: 30)
        subtitleLabel.alpha = 0
        formStackView.transform = CGAffineTransform(translationX: 0, y: 40)
        buttonStackView.alpha = 0
        
        logoImageView.alpha = 0
        titleLabel.alpha = 0
        formStackView.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateEntrance()
        
        // Gradient'i doğru boyutta ayarlama
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.updateGradientFrame()
            self.updateButtonGradientFrame()
        }
    }
    
    func animateEntrance() {
        UIView.animate(withDuration: 0.8, delay: 0.1, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5) {
            self.logoImageView.alpha = 1
            self.logoImageView.transform = .identity
        }
        
        UIView.animate(withDuration: 0.6, delay: 0.3) {
            self.titleLabel.alpha = 1
            self.titleLabel.transform = .identity
        }
        
        UIView.animate(withDuration: 0.6, delay: 0.4) {
            self.subtitleLabel.alpha = 1
        }
        
        UIView.animate(withDuration: 0.8, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3) {
            self.formStackView.alpha = 1
            self.formStackView.transform = .identity
        }
        
        UIView.animate(withDuration: 0.6, delay: 0.7) {
            self.buttonStackView.alpha = 1
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateGradientFrame()
        updateButtonGradientFrame()
    }
    
    func updateGradientFrame() {
        if let gradientLayer = backgroundView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = view.bounds
        }
    }
    
    func updateButtonGradientFrame() {
        if let gradientLayer = registerButton.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = registerButton.bounds
        }
    }
    
    // Floating label animations
    @objc func emailTextFieldChanged() {
        animateFloatingLabel(floatingLabel: emailFloatingLabel, textField: emailTextField)
        validateEmailFormat()
    }
    
    @objc func passwordTextFieldChanged() {
        animateFloatingLabel(floatingLabel: passwordFloatingLabel, textField: passwordTextField)
        validatePasswordStrength()
    }
    
    @objc func confirmPasswordTextFieldChanged() {
        animateFloatingLabel(floatingLabel: confirmPasswordFloatingLabel, textField: confirmPasswordTextField)
        validatePasswordMatch()
    }
    
    @objc func emailTextFieldEditingBegan() {
        animateFocus(containerView: emailContainerView, iconImageView: emailIconImageView)
    }
    
    @objc func passwordTextFieldEditingBegan() {
        animateFocus(containerView: passwordContainerView, iconImageView: passwordIconImageView)
    }
    
    @objc func confirmPasswordTextFieldEditingBegan() {
        animateFocus(containerView: confirmPasswordContainerView, iconImageView: confirmPasswordIconImageView)
    }
    
    @objc func emailTextFieldEditingEnded() {
        animateUnfocus(containerView: emailContainerView, iconImageView: emailIconImageView)
    }
    
    @objc func passwordTextFieldEditingEnded() {
        animateUnfocus(containerView: passwordContainerView, iconImageView: passwordIconImageView)
    }
    
    @objc func confirmPasswordTextFieldEditingEnded() {
        animateUnfocus(containerView: confirmPasswordContainerView, iconImageView: confirmPasswordIconImageView)
    }
    
    // Validation functions
    func validateEmailFormat() {
        guard let email = emailTextField.text, !email.isEmpty else { return }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        let isValidEmail = emailPredicate.evaluate(with: email)
        
        UIView.animate(withDuration: 0.2) {
            if isValidEmail {
                self.emailContainerView.layer.borderColor = UIColor.systemGreen.cgColor
                self.emailIconImageView.tintColor = UIColor.systemGreen
            } else {
                self.emailContainerView.layer.borderColor = UIColor.systemOrange.cgColor
                self.emailIconImageView.tintColor = UIColor.systemOrange
            }
        }
    }
    
    func validatePasswordStrength() {
        guard let password = passwordTextField.text, !password.isEmpty else { return }
        let isStrongPassword = password.count >= 6
        
        UIView.animate(withDuration: 0.2) {
            if isStrongPassword {
                self.passwordContainerView.layer.borderColor = UIColor.systemGreen.cgColor
                self.passwordIconImageView.tintColor = UIColor.systemGreen
            } else {
                self.passwordContainerView.layer.borderColor = UIColor.systemOrange.cgColor
                self.passwordIconImageView.tintColor = UIColor.systemOrange
            }
        }
    }
    
    func validatePasswordMatch() {
        guard let password = passwordTextField.text,
              let confirmPassword = confirmPasswordTextField.text,
              !confirmPassword.isEmpty else { return }
        
        let passwordsMatch = password == confirmPassword
        
        UIView.animate(withDuration: 0.2) {
            if passwordsMatch {
                self.confirmPasswordContainerView.layer.borderColor = UIColor.systemGreen.cgColor
                self.confirmPasswordIconImageView.tintColor = UIColor.systemGreen
            } else {
                self.confirmPasswordContainerView.layer.borderColor = UIColor.systemRed.cgColor
                self.confirmPasswordIconImageView.tintColor = UIColor.systemRed
            }
        }
    }
    
    func animateFloatingLabel(floatingLabel: UILabel, textField: UITextField) {
        let shouldShow = !(textField.text?.isEmpty ?? true)
        
        UIView.animate(withDuration: 0.2) {
            floatingLabel.alpha = shouldShow ? 1.0 : 0.0
        }
    }
    
    func animateFocus(containerView: UIView, iconImageView: UIImageView) {
        UIView.animate(withDuration: 0.2) {
            containerView.layer.borderColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 0.8).cgColor
            containerView.layer.borderWidth = 2
            iconImageView.tintColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.0)
            containerView.transform = CGAffineTransform(scaleX: 1.02, y: 1.02)
        }
    }
    
    func animateUnfocus(containerView: UIView, iconImageView: UIImageView) {
        UIView.animate(withDuration: 0.2) {
            containerView.layer.borderColor = UIColor(white: 1.0, alpha: 0.1).cgColor
            containerView.layer.borderWidth = 1
            iconImageView.tintColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 0.8)
            containerView.transform = .identity
        }
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }
    
    @objc func buttonReleased(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1) {
            sender.transform = .identity
        }
    }
    
    @objc func registerButtonTapped(){
        addButtonRippleEffect(button: registerButton)
        presenter?.registerButtonTapped(email: emailTextField.text, password: passwordTextField.text)
    }
    
    @objc func loginButtonTapped(){
        addButtonRippleEffect(button: loginButton)
        dismiss(animated: true, completion: nil)
    }
    
    func addButtonRippleEffect(button: UIButton) {
        let rippleLayer = CAShapeLayer()
        let center = CGPoint(x: button.bounds.midX, y: button.bounds.midY)
        let startRadius: CGFloat = 0
        let endRadius = max(button.bounds.width, button.bounds.height)
        
        rippleLayer.path = UIBezierPath(arcCenter: center, radius: startRadius, startAngle: 0, endAngle: 2 * .pi, clockwise: true).cgPath
        rippleLayer.fillColor = UIColor(white: 1.0, alpha: 0.3).cgColor
        rippleLayer.opacity = 0
        
        button.layer.addSublayer(rippleLayer)
        
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = endRadius / startRadius
        
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0.6
        opacityAnimation.toValue = 0
        
        let animationGroup = CAAnimationGroup()
        animationGroup.animations = [scaleAnimation, opacityAnimation]
        animationGroup.duration = 0.4
        animationGroup.fillMode = .removed
        
        rippleLayer.add(animationGroup, forKey: "ripple")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            rippleLayer.removeFromSuperlayer()
        }
    }
}

extension RegisterViewController: RegisterViewProtocol{
    
    func showLoading() {
        UIView.animate(withDuration: 0.3) {
            self.activity.startAnimating()
            self.registerButton.isEnabled = false
            self.registerButton.alpha = 0.6
            self.formStackView.alpha = 0.5
        }
    }
    
    func hideLoading() {
        UIView.animate(withDuration: 0.3) {
            self.activity.stopAnimating()
            self.registerButton.isEnabled = true
            self.registerButton.alpha = 1.0
            self.formStackView.alpha = 1.0
        }
    }
    
    func showRegisterError(_ message: String) {
        // Modern error alert
        let alert = UIAlertController(title: "⚠️ Kayıt Hatası", message: message, preferredStyle: .alert)
        
        // Alert'e modern styling
        alert.view.tintColor = UIColor(red: 0.2, green: 0.8, blue: 0.4, alpha: 1.0)
        
        let action = UIAlertAction(title: "Tekrar Dene", style: .default) { _ in
            // Input field'lara focus animasyonu
            UIView.animate(withDuration: 0.5, delay: 0, options: [.autoreverse, .repeat]) {
                self.emailContainerView.layer.borderColor = UIColor.red.cgColor
                self.passwordContainerView.layer.borderColor = UIColor.red.cgColor
                self.confirmPasswordContainerView.layer.borderColor = UIColor.red.cgColor
            } completion: { _ in
                UIView.animate(withDuration: 0.3) {
                    self.emailContainerView.layer.borderColor = UIColor(white: 1.0, alpha: 0.1).cgColor
                    self.passwordContainerView.layer.borderColor = UIColor(white: 1.0, alpha: 0.1).cgColor
                    self.confirmPasswordContainerView.layer.borderColor = UIColor(white: 1.0, alpha: 0.1).cgColor
                }
            }
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func navigateToMainScreen() {
        // Success animation
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3) {
            self.registerButton.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.registerButton.transform = .identity
            }
        }
        
        let alert = UIAlertController(title: "🎉 Hoş Geldiniz!", message: "Hesabınız başarıyla oluşturuldu!", preferredStyle: .alert)
        alert.view.tintColor = UIColor(red: 0.2, green: 0.8, blue: 0.4, alpha: 1.0)
        alert.addAction(UIAlertAction(title: "Devam Et", style: .default) { _ in
            // Alert kapandıktan sonra ekranı dismiss et
            self.dismiss(animated: true, completion: nil)
        })
        present(alert, animated: true, completion: nil)
    }
}
