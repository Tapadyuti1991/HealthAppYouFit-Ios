//
//  getStartedRegisterViewController.swift
//  YouFit
//
//  Created by Tapadyuti Maiti on 4/26/18.
//  Copyright © 2018 Tapadyuti Maiti. All rights reserved.
//

import UIKit

class getStartedRegisterViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

  

    @IBAction func authorize(_ sender: CustomButton) {
        authorizeHealthKit()
    }
    
    private func authorizeHealthKit() {
        
        HealthKitSetupAssistant.authorizeHealthKit { (authorized, error) in
            
            guard authorized else {
                
                let baseMessage = "HealthKit Authorization Failed"
                
                if let error = error {
                    print("\(baseMessage). Reason: \(error.localizedDescription)")
                } else {
                    print(baseMessage)
                }
                
                return
            }
            
            print("HealthKit Successfully Authorized.")
        }
        
    }

}
