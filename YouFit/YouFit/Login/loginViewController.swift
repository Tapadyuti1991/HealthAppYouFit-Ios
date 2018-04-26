//
//  LoginViewController.swift
//  YouFit
//
//  Created by Tapadyuti Maiti on 4/26/18.
//  Copyright © 2018 Tapadyuti Maiti. All rights reserved.
//

import UIKit

class loginViewController: UIViewController {

   
    
    @IBOutlet weak var grad: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateBackground()
        
    }
    
    
    @IBAction func login(_ sender: UIButton) {
        goToHome()
//        performSegue(withIdentifier: "tabBarViewController", sender: self)
        
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func goToHome(){
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarViewController") as! tabBarViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParentViewController: self)
    }
    
    
    func animateBackground(){
        print("Inside animatiton")
        UIView.animate(withDuration: 15, delay: 0, options: [.autoreverse,.curveLinear,.repeat], animations: {
            let x = -(self.grad.frame.width - self.view.frame.width * 2)
            self.grad.transform = CGAffineTransform(translationX: x, y: 0)
        })
    }
    

}
