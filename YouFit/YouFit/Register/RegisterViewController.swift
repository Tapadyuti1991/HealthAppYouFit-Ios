//
//  RegisterViewController.swift
//  YouFit
//
//  Created by Tapadyuti Maiti on 4/26/18.
//  Copyright © 2018 Tapadyuti Maiti. All rights reserved.
//

import UIKit
import CoreData
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
        
        if (userName.text?.count == 0 || password.text?.count == 0){
            
           let vc =  makeUIAlertController(Message: "Please Enter the UserEmail and Password")
            self.present(vc, animated: true, completion: nil)
        }
        
        else{
            do{
                dataUser = try context.fetch(Users.fetchRequest())
                var flagU:Bool = true
                for e in dataUser{
                    if e.email == userName.text! {
                        flagU = false
                        print("Equals")
                        let vc =  makeUIAlertController(Message: "Sorry! This username has been already taken")
                        userName.text! = ""
                        password.text! = ""
                        self.present(vc, animated: true, completion: nil)
                    }
                    break
                }
                if flagU {
                    let user = Users(context: context)
                    user.email = userName.text!
                    user.password = password.text!
                    
                    appDelegate.saveContext()
                    currentUserLoggedIn = user  //session Started for Current User 
                    userName.text! = ""
                    password.text! = ""
                    performSegue(withIdentifier: "goTowelcome", sender: self)
                }
            }
            catch {
                let vc =  makeUIAlertController(Message: "Erro Occured ,Please Enter Again!")
                self.dismiss(animated: true, completion: nil)
                self.userName.text = ""
                self.password.text = ""
            }
        }
    }
    
    
    
    
    
    func animateBackground(){
        print("Inside animatiton")
        UIView.animate(withDuration: 15, delay: 0, options: [.autoreverse,.curveLinear,.repeat], animations: {
            let x = -(self.grad.frame.width - self.view.frame.width * 2)
            self.grad.transform = CGAffineTransform(translationX: x, y: 0)
        })
    }

  

}
