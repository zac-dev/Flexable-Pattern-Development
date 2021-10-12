//
//  SimplerViewController.swift
//  FlexablePatternDemo
//
//  Created by Zachary Burgess on 13/09/2021.
//

///
/// Simple M.V.C:
/// Simple M.V.C. is as it always was!
/// In this simple example I have subdevided the separate parts we will later move to other classes
/// This demonstrates how a pattern moves classes as it evolves rather than change anything.
/// Note that after removing all the comments the ComplexMVCViewControlller/ComplexMVCViewModel combined
/// are virtualy the same number of lines as this class!
///

import UIKit

final class SimpleMVCViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var myLabel: UILabel!
    @IBOutlet private weak var myOtherLabel: UILabel!
    @IBOutlet private weak var myButton: UIButton!
    
    // MARK: - Model State properties
    private var myModel: SimpleModel!
    private var myViewState: Bool = false
    private let nextViewIdentifier = "next"
    private let modelKey: String = "simpleModel"
    
    // MARK: - Model Data sub systems
    private let myDecoder: JSONDecoder = JSONDecoder()
    private let myEncoder: JSONEncoder = JSONEncoder()
    private let storageSystem: UserDefaults = UserDefaults.standard
    
    // MARK: - View Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeModelState()
        initializeViewState(text: "Simple M.V.C.",
                            otherText: "some partial static text \(myModel.name)")
    }
    
    // MARK: - View State change methods
    /// model changes and routing are handled in the view controlller
    @IBAction func didTapMyButton(_ sender: UIButton) {
        updateDateAndMoveOn()
    }
    
    // MARK: - View Routing methods
    /// screen coordination and dependancy managment are handled in the view controller when using segues
    /// it is better to be consistant here and either NEVER use segues or always use them, I may publish another
    /// project that doesn't use them to demo that
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == nextViewIdentifier,
           let destination = segue.destination as? MyNextSimpleViewController,
           let model = sender as? SimpleModel {
            destination.model = model
        }
    }
    
    // MARK: - View Reactions to model state change methods
    private func initializeViewState(text: String, otherText: String) {
        myLabel.text = text
        myOtherLabel.text = otherText
    }
    
    private func showErrorState(type: String, error: Error) {
        myLabel.text = "there was an error with \(type)! \(error.localizedDescription)"
    }
    
    // MARK: - Model reactions to view state change methods
    private func initializeModelState() {
        getSimpleModel()
    }
    
    private func updateDateAndMoveOn() {
        myModel.date = Date()
        performSegue(withIdentifier: nextViewIdentifier, sender: myModel)
    }
    
    /// data retrival is handled in the view controller
    private func getSimpleModel() {
        if let modelAsData = storageSystem.data(forKey: modelKey) {
            do {
                myModel = try myDecoder.decode(SimpleModel.self, from: modelAsData)
            }
            catch {
                showErrorState(type: "decoding", error: error)
            }
        }
        else {
            myModel = SimpleModel(date: Date(), name: "default simple model")
            do {
                let myModelAsData = try myEncoder.encode(myModel)
                storageSystem.setValue(myModelAsData, forKey: modelKey)
            }
            catch {
                showErrorState(type: "encoding", error: error)
            }
        }
    }
}
