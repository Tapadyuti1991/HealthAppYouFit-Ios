//
//  RegisterViewController.swift
//  YouFit
//
//  Created by Tapadyuti Maiti on 4/26/18.
//  Copyright © 2018 Tapadyuti Maiti. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var grad: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateBackground()
    }
    

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func register(_ sender: CustomButton) {
        
        performSegue(withIdentifier: "goTowelcome", sender: self)
        
        
    }
    
    
    
    
    
    func animateBackground(){
        print("Inside animatiton")
        UIView.animate(withDuration: 15, delay: 0, options: [.autoreverse,.curveLinear,.repeat], animations: {
            let x = -(self.grad.frame.width - self.view.frame.width * 2)
            self.grad.transform = CGAffineTransform(translationX: x, y: 0)
        })
    }

  

}
