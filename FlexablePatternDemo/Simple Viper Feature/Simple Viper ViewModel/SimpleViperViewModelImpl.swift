//
//  SimpleViperViewModelImpl.swift
//  FlexablePatternDemo
//
//  Created by Zachary Burgess on 15/09/2021.
//

import Foundation

final class SimpleViperViewModelImpl: SimpleViperViewModel {
    
    // MARK: - Model state properties
    var myModel: SimpleModel!
    var myViewState: Bool = false
    var nextViewIdentifier = "next"
    let text: String = "some static text"
    var otherText: String {
        return "some partial static text \(myModel.name)"
    }
    weak var presenter: SimpleViperViewPresenter?
    weak var interactor: SimpleViperViewInteractor?
    
    init(myViewState: Bool,
         presenter: SimpleViperViewPresenter? = nil,
         interactor: SimpleViperViewInteractor? = SimpleViperViewInteractorImpl()) {
        self.myViewState = myViewState
        self.presenter = presenter
        self.interactor = interactor
    }
    
    func updateDateAndMoveOn() {
        myModel.date = Date()
        presenter?.performSegue(withIdentifier: nextViewIdentifier, sender: myModel)
    }
    
    func initializeModelState() {
        interactor?.getSimpleModel { result in
            switch result {
            case .success(let model):
                myModel = model
                presenter?.initializeViewState(text: text, otherText: otherText)
            case .failure(let error):
                presenter?.showErrorState(type: "get", error: error)
            }
        }
    }
}
