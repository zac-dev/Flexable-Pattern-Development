//
//  SimpleViperViewPresenter.swift
//  FlexablePatternDemo
//
//  Created by Zachary Burgess on 15/09/2021.
//

/// The presenter that is not a Presenter, as intended by the VIPER pattern! In pure VIPER the presenter is the ViewModel in MVVM.
/// In VIPER:
/// It is the class that "presents" the model domain, to the user via some abstracted user interface. By which I mean we avoid calling
/// it a view. which would dictate there is an absolute visual element to said user interface.
/// but mostly so they could use P in the acronim and use the cool name of VIPER!
/// In MVVM:
/// it is a class that model's the view and is the Controller for the model domain. 
/// Not only does ViewModel still make sense as a name but I do like using the term Presenter to represent the view domain from the s
///

protocol SimpleViperViewPresenter: AnyObject {
    func performSegue(withIdentifier identifier: String, sender: Any?)
    func initializeViewState(text: String, otherText: String)
    func showErrorState(type: String, error: Error)
}
