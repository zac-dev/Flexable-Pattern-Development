//
//  SimpleModel.swift
//  FlexablePatternDemo
//
//  Created by Zachary Burgess on 13/09/2021.
//

import Foundation

final class SimpleModel: Codable {
    
    let name: String
    var date: Date
    
    init(date: Date, name: String) {
        self.date = date
        self.name = name
    }
}
