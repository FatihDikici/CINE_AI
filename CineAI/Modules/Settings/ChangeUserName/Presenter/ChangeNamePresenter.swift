//
//  ChangeNamePresenter.swift
//  CineAI
//
//  Created by MB-BTMC001 on 11.09.2025.
//

import Foundation


class ChangeNamePresenter: ChangeNamePresenterProtocol{
    
    weak var view: ChangeNameViewProtocol?
    var interactor:ChangeNameInteractorProtocol?
    var router: ChangeNameRouterProtocol?
    var CurrentName: String?
    
    func viewDidLoad() {}
    
    func didTapSvaeButton(newUserName: String) {
        view?.showLoading()
        CurrentName = newUserName
        interactor?.updateUserName(newUserName: newUserName)
    }
    func didTapBackButton() {
        router?.navigateBack()
    }
}

extension ChangeNamePresenter: ChangeNameInteractorOutputProtocol{
    
    func userNameUpdateSuccess() {
        view?.hideLoading()

        if let newUserName = CurrentName{
            router?.delegate?.didChangeUsername(newUserName: newUserName)
            CurrentName = newUserName
        }
        router?.navigateBack()
    }
    
    func userNameUpdateFailed(error: Error) {
        view?.hideLoading()
        view?.displayError(message: error.localizedDescription)
    }
}
