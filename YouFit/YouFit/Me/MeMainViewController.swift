//
//  MeMainViewController.swift
//  YouFit
//
//  Created by Tapadyuti Maiti on 4/27/18.
//  Copyright © 2018 Tapadyuti Maiti. All rights reserved.
//

import UIKit

class MeMainViewController: UIViewController {

    @IBOutlet weak var hiUser: UIView!
    @IBOutlet weak var userStreak: UIView!
    @IBOutlet weak var logWeight: UIView!
    @IBOutlet weak var bio: UIView!
    @IBOutlet weak var updatebio: UIView!
    
    
    @IBOutlet weak var userGreeting: UILabel!
    @IBOutlet weak var totalPoints: UILabel!
    @IBOutlet weak var streak: UILabel!
    
    @IBOutlet weak var UserCurrentWeight: UILabel!
    @IBOutlet weak var stepperW: UIStepper!
    @IBOutlet weak var bmiLabel: UILabel!
    
    @IBOutlet weak var bmiStatus: UILabel!
    override func viewWillAppear(_ animated: Bool) {
       
        hiUser.dropShadow()
        userStreak.dropShadow()
        logWeight.dropShadow()
        bio.dropShadow()
        updatebio.dropShadow()
        stepperW.value = 100.1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    @IBAction func updateBio(_ sender: UIButton) {
       performSegue(withIdentifier: "updateBio", sender: self)

    }
    
    
    @IBAction func stepperWeight(_ sender: UIStepper) {
        
        UserCurrentWeight.text = String(sender.value)
        
    }
    
    
    
 
}
