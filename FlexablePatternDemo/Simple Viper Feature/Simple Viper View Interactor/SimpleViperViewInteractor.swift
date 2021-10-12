//
//  SimpleViperViewInteractor.swift
//  FlexablePatternDemo
//
//  Created by Zachary Burgess on 15/09/2021.
//

import Foundation

protocol SimpleViperViewInteractor: AnyObject {
    func getSimpleModel(_ compeltion: ((Result<SimpleModel, Error>) -> Void))
}
