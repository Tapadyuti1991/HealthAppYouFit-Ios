//
//  LoginViewController.swift
//  YouFit
//
//  Created by Tapadyuti Maiti on 4/26/18.
//  Copyright © 2018 Tapadyuti Maiti. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func login(_ sender: UIButton) {
        performSegue(withIdentifier: "goToUserHome", sender: self)
        
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
    }
    

}
