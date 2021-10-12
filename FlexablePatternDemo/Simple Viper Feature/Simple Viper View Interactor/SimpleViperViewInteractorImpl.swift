//
//  SimpleViperViewInteractorImpl.swift
//  FlexablePatternDemo
//
//  Created by Zachary Burgess on 15/09/2021.
//

import Foundation

///
/// Simple Viper
/// The idea here is to fomalize the relationship between our classes that we createted with complex MVC.
/// And to split out the model domain interaction into a spcialized interactor class.
///

final class SimpleViperViewInteractorImpl: SimpleViperViewInteractor {
    
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
    
    func getSimpleModel(_ compeltion: ((Result<SimpleModel, Error>) -> Void)) {
        
        if let modelAsData = storageSystem.data(forKey: "simpleModel") {
            do {
                let myModel = try myDecoder.decode(SimpleModel.self, from: modelAsData)
                compeltion(.success(myModel))
            }
            catch {
                compeltion(.failure(error))
            }
        }
        else {
            let myModel = SimpleModel(date: Date(), name: "some name")
            do {
                let myModelAsData = try myEncoder.encode(myModel)
                storageSystem.setValue(myModelAsData, forKey: "simpleModel")
                compeltion(.success(myModel))
            }
            catch {
                compeltion(.failure(error))
            }
        }
    }
}
