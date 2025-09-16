//
//  ChangeNameViewController.swift
//  CineAI
//
//  Created by MB-BTMC001 on 11.09.2025.
//

import UIKit

class ChangeNameViewController: UIViewController {

    var presenter: ChangeNamePresenterProtocol?
    weak var delegate: ChangeUsernameDelegate?
    
    private let usernameTextField = UITextField()
    private let saveButton = UIButton(type: .system)
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let errorLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    func setupUI(){
        view.backgroundColor = UIColor(red: 0.05, green: 0.05, blue: 0.1, alpha: 1.0) 
        setupNavigationBar()
        setupUsernameTextField()
        setupSaveButton()
        setupActivityIndicator()
        setupErrorLabel()
    }
    
    func setupNavigationBar() {
           title = "Kullanıcı Adı Değiştir"
           navigationController?.navigationBar.prefersLargeTitles = false
           navigationController?.navigationBar.tintColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.0)
           
           let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style: .plain, target: self, action: #selector(backButtonTapped))
           navigationItem.leftBarButtonItem = backButton
       }
    func setupUsernameTextField() {
           usernameTextField.placeholder = "Yeni kullanıcı adı"
           usernameTextField.borderStyle = .roundedRect
           usernameTextField.backgroundColor = UIColor(white: 1.0, alpha: 0.1)
           usernameTextField.textColor = .white
           usernameTextField.attributedPlaceholder = NSAttributedString(string: "Yeni kullanıcı adı", attributes: [NSAttributedString.Key.foregroundColor: UIColor(white: 1.0, alpha: 0.5)])
           usernameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: usernameTextField.frame.height))
           usernameTextField.leftViewMode = .always
           usernameTextField.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(usernameTextField)
           
           NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
           ])
       }
    func setupSaveButton() {
           saveButton.setTitle("Kaydet", for: .normal)
           saveButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
           saveButton.setTitleColor(.white, for: .normal)
           saveButton.backgroundColor = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.0)
           saveButton.layer.cornerRadius = 15
           saveButton.translatesAutoresizingMaskIntoConstraints = false
           saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
           view.addSubview(saveButton)
           
           NSLayoutConstraint.activate([
               saveButton.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30),
               saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
               saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
               saveButton.heightAnchor.constraint(equalToConstant: 55)
           ])
       }
     func setupActivityIndicator() {
           activityIndicator.hidesWhenStopped = true
           activityIndicator.color = UIColor(red: 1.0, green: 0.7, blue: 0.2, alpha: 1.0)
           activityIndicator.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(activityIndicator)
           
           NSLayoutConstraint.activate([
               activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
               activityIndicator.centerYAnchor.constraint(equalTo: saveButton.centerYAnchor)
           ])
       }
    
    func setupErrorLabel() {
            errorLabel.textColor = .red
            errorLabel.font = .systemFont(ofSize: 14)
            errorLabel.textAlignment = .center
            errorLabel.numberOfLines = 0
            errorLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(errorLabel)
            
            NSLayoutConstraint.activate([
                errorLabel.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 15),
                errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
        }

        @objc func saveButtonTapped() {
            if let newUsername = usernameTextField.text, !newUsername.isEmpty {
                presenter?.didTapSvaeButton(newUserName: newUsername)
            }
        }
        
        @objc func backButtonTapped() {
            presenter?.didTapBackButton()
        }
    }

extension ChangeNameViewController: ChangeNameViewProtocol {
    func showLoading() {
        activityIndicator.startAnimating()
        saveButton.isEnabled = false
        saveButton.alpha = 0.5
        errorLabel.text = ""
    }

    func hideLoading() {
        activityIndicator.stopAnimating()
        saveButton.isEnabled = true
        saveButton.alpha = 1.0
    }

    func displayError(message: String) {
        errorLabel.text = message
    }

    func navigateBackToSettings() {
        navigationController?.popViewController(animated: true)
    }
}
