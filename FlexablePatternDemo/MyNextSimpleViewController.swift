//
//  MyNextSimpleViewController.swift
//  FlexablePatternDemo
//
//  Created by Zachary Burgess on 14/09/2021.
//

import UIKit

final class MyNextSimpleViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var myLabel: UILabel!
    /// some outlets here
    
    // MARK: - view state properties
    var model: SimpleModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let model = model {
            // do initilization with model
            myLabel.text = "\(model.name) @ \(model.date)"
        }
        else {
            // do defualt initilization
        }
    }
}
