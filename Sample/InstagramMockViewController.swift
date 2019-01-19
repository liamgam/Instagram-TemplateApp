//
//  InstagramMockViewController.swift
//  InstagramTemplate
//
//  Created by Rinni Swift on 1/15/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit

class InstagramMockViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = 50
        profileImage.backgroundColor = UIColor(red: 0.86, green: 0.86, blue: 0.86, alpha: 1)
        
    }
}
