import Foundation

class RegisterPresenter: RegisterPresenterProtocol {
    
    weak var view: RegisterViewProtocol?
    var interactor: RegisterInteractorProtocol
    var router: RegisterRouterProtocol
    
    init(view: RegisterViewProtocol, interactor: RegisterInteractorProtocol, router: RegisterRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        // Ekran yüklendiğinde yapılacak işlemler
    }
    
    func registerButtonTapped(email: String?, password: String?) {
        guard let email = email, !email.isEmpty,
              let password = password, !password.isEmpty else {
            self.view?.showRegisterError("Lütfen e-posta ve şifrenizi girin.")
            return
        }
        
        self.view?.showLoading()
        interactor.register(email: email, password: password)
    }
}

// MARK: - RegisterInteractorOutputProtocol

extension RegisterPresenter: RegisterInteractorOutputProtocol {
    
    func didRegisterSuccess() {
        self.view?.hideLoading()
        router.navigateToMainScreen()
    }
    
    func didRegisterFail(error: Error) {
        self.view?.hideLoading()
        self.view?.showRegisterError(error.localizedDescription)
    }
}
