//
//  InstagramMockViewController.swift
//  InstagramTemplate
//
//  Created by Rinni Swift on 1/15/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class InstagramMockViewController: UIViewController {

    @IBOutlet weak var editProfileButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editProfileButton.layer.cornerRadius = 5
        editProfileButton.layer.borderWidth = 1
        editProfileButton.layer.borderColor = #colorLiteral(red: 0.8588235294, green: 0.8588235294, blue: 0.8588235294, alpha: 1)
        
    }
}
