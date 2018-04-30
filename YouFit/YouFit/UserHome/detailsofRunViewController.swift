//
//  detailsofRunViewController.swift
//  YouFit
//
//  Created by Tapadyuti Maiti on 4/28/18.
//  Copyright © 2018 Tapadyuti Maiti. All rights reserved.
//

import UIKit

class detailsofRunViewController: UIViewController {
    
    var calorie:Double?
    
    @IBOutlet weak var calorieLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        calorieLabel.text = "\(calorie!)Calories!"
    }
    
}
