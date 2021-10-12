//
//  SimpleViperViewController.swift
//  FlexablePatternDemo
//
//  Created by Zachary Burgess on 14/09/2021.
//

import UIKit

final class SimpleViperViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var myLabel: UILabel!
    @IBOutlet private weak var myOtherLabel: UILabel!
    @IBOutlet private weak var myButton: UIButton!
    
    // MARK: - View State property (note its singular)
    /// view state now in view model
    var viewModel: SimpleViperViewModel? {
        didSet { viewModel?.presenter = self }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.initializeModelState()
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

extension SimpleViperViewController: SimpleViperViewPresenter {
    
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
}
