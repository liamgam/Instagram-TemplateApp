//
//  ViewController.swift
//  InstagramTemplate
//
//  Created by Rinni Swift on 1/5/19.
//  Copyright © 2019 Rinni Swift. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    // MARK: labels
    @IBOutlet weak var usernameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // set instagram color background
        view.backgroundColor = UIColor(displayP3Red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // shows the usersname when user opens up this page
        let profiles = CoreDataHelper.retrieveprofile()
        let profile = profiles.first
        usernameTextField.text = profile?.username // ?? ""
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // use to make the view or any subview that is the first responder resign (optionally force)
        self.view.endEditing(true)
        
        // set the username text field to the one saved in coredata (?)
        let profiles = CoreDataHelper.retrieveprofile()
        let profile = profiles.first
        profile?.username = usernameTextField.text
        
        // create a new profile and set the username to the textfield user input
        let username = CoreDataHelper.newProfile()
        username.username = usernameTextField.text
        CoreDataHelper.saveProfile()
        
    }
    
}

