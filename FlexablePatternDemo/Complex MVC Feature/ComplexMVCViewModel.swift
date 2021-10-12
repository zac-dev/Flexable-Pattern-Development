//
//  ComplexMVCViewModel.swift
//  FlexablePatternDemo
//
//  Created by Zachary Burgess on 14/09/2021.
//

///
/// Complex M.V.C:
/// What I mean is somthing as MVVM as we can get without proper bindings so not MVVM! Still actually MVC!
/// This ends up just being a division of the contorller domain into two distinct classes.
/// 1. a ViewController as an interface to the view domain and to control the view domain state changes.
/// 2. a ViewModel as an interface to the model domain and to control the model domain's state changes.
///
/// Note: When developing in (as close to as possible) MVVM, remeber that your view controller's state should all be stored in your viewModel
/// which means that your view contorller should only have UIView sub-classes and a SINGLE view model. nothing else, anything that the
/// view controller needs to present itself is inside of the view model.
///
/// Furthermore, you willl notice that the view model never talks back to the view controller. It updates the view via its view
/// (or later preserter) interface. This makes the flow of activity unidirectional. 
///

import Foundation

final class ComplexMVCViewModel {
    
    // MARK: - Model state properties
    var myModel: SimpleModel!
    var myViewState: Bool = false
    var nextViewIdentifier = "next"
    let text: String = "Complex M.V.C."
    var otherText: String {
        return "some partial static text \(myModel.name)"
    }
    weak var view: ComplexMVCViewController?
    
    // MARK: - model data sub systems
    private let myDecoder: JSONDecoder
    private let myEncoder: JSONEncoder
    private let storageSystem: UserDefaults
    
    /// we pass in our subsystem dependancies defaulted to apple provided ones
    /// this is so that fakes/spys can be used in testing
    init(myDecoder: JSONDecoder = JSONDecoder(),
         myEncoder: JSONEncoder = JSONEncoder(),
         storageSystem: UserDefaults = UserDefaults.standard) {
        self.myDecoder = myDecoder
        self.myEncoder = myEncoder
        self.storageSystem = storageSystem
    }
    
    // MARK: - Model Reactions to view state change methods
    func updateDateAndMoveOn() {
        myModel.date = Date()
        view?.performSegue(withIdentifier: nextViewIdentifier, sender: myModel)
    }
    
    func initializeModelState() {
        getSimpleModel()
        view?.initializeViewState(text: text, otherText: otherText)
    }
    
    /// data retrival is handled in the view model
    private func getSimpleModel() {
        if let modelAsData = storageSystem.data(forKey: "simpleModel") {
            do {
                myModel = try myDecoder.decode(SimpleModel.self, from: modelAsData)
            }
            catch {
                view?.showErrorState(type: "decoding!", error: error)
            }
        }
        else {
            myModel = SimpleModel(date: Date(), name: "some name")
            do {
                let myModelAsData = try myEncoder.encode(myModel)
                storageSystem.setValue(myModelAsData, forKey: "simpleModel")
            }
            catch {
                view?.showErrorState(type: "encoding!", error: error)
            }
        }
    }
}
