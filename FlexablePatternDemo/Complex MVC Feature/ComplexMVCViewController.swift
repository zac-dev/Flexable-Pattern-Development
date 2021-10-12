//
//  ComplexMVCViewController.swift
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

import UIKit

final class ComplexMVCViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var myLabel: UILabel!
    @IBOutlet private weak var myOtherLabel: UILabel!
    @IBOutlet private weak var myButton: UIButton!
    
    // MARK: - View State property (note its singular)
    /// view state now in view model
    var viewModel: ComplexMVCViewModel? {
        didSet { viewModel?.view = self }
    }
    
    // MARK: - View Lifecycle methods
    /// here we removed the call to initise the view state as we know it uses the model.
    /// once the model has initilised IT will tell the view to update when and if its state chages
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ComplexMVCViewModel()
        viewModel?.initializeModelState()
    }
    
    // MARK: - View State chage methods
    /// changes in the view domain are comunicated to the view model, this will decid how to act
    @IBAction func didTapMyButton(_ sender: UIButton) {
        viewModel?.updateDateAndMoveOn()
    }
    
    // MARK: - View Reactions to viewmodel state change methods
    /// this is how the viewmodel will tell us to initilise our content
    func initializeViewState(text: String, otherText: String) {
        myLabel.text = text
        myOtherLabel.text = otherText
    }
    
    /// this is how the viewmodel will tell us to update our content
    func showErrorState(type: String, error: Error) {
        myLabel.text = "there was an error with \(type)! \(error.localizedDescription)"
    }
    
    // MARK: - View Routing methods
    /// screen coordination and dependancy managment are handled in the view controller when using segues
    /// it is better to be consistant here and either NEVER use segues or always use them, I may publish another
    /// project that doesn't use them to demo customised view coordination.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == viewModel?.nextViewIdentifier,
           let destination = segue.destination as? MyNextSimpleViewController,
           let model = sender as? SimpleModel {
            destination.model = model
        }
    }
}
