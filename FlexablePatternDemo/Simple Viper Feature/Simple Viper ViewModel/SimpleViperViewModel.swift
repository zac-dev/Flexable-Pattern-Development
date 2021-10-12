//
//  SimpleViperViewModel.swift
//  FlexablePatternDemo
//
//  Created by Zachary Burgess on 14/09/2021.
//

import Foundation

protocol SimpleViperViewModel: AnyObject {
    var presenter: SimpleViperViewPresenter? { get set }
    var nextViewIdentifier: String { get }
    
    func updateDateAndMoveOn()
    func initializeModelState()
}
