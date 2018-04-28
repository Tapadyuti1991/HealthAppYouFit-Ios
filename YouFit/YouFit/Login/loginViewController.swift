//
//  LoginViewController.swift
//  YouFit
//
//  Created by Tapadyuti Maiti on 4/26/18.
//  Copyright © 2018 Tapadyuti Maiti. All rights reserved.
//

import UIKit
import CoreData
class loginViewController: UIViewController {

   
    
    @IBOutlet weak var grad: UIImageView!
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animateBackground()
    }
    
    
    @IBAction func login(_ sender: UIButton) {
        
//        let pat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
//
//        let testStr = userName.text!
//
//        let regex = try! NSRegularExpression(pattern: pat)
//        let matches = regex.matches(in: userName.text!, options: regex, range:NSRange(location: 0, length: testStr.characters.count))
        if (userName.text?.count == 0 || password.text?.count == 0){
            
            let vc =  makeUIAlertController(Message: "Please Enter the UserEmail and Password")
            self.present(vc, animated: true, completion: nil)
        }
//        if(matches.count < 1){
//            let vc =  makeUIAlertController(Message: "Please Enter valid Mail address")
//            self.present(vc, animated: true, completion: nil)
//            
//        }
        // (4):
        

            
            
            
        else{
            
            do{
                dataUser = try context.fetch(Users.fetchRequest())
                var flagU:Bool = false
                for e in dataUser{
                    if e.email == userName.text! {
                        guard (e.password == password.text!) else{
                            userName.text! = ""
                            password.text! = ""
                          
                            let vc =  makeUIAlertController(Message: "PassWord Not Matched, Please Try again")
                            self.present(vc, animated: true, completion: nil)
                            return
                        }
                        
                        flagU = true
                        currentUserLoggedIn = e    //Session Started
                    }
                }
                if flagU {
                    userName.text! = ""
                    password.text! = ""
                    
                    goToHome()
                }
                else{
                    let vc =  makeUIAlertController(Message: "Please Register first !")
                    self.present(vc, animated: true, completion: nil)
                }
                
            }
            catch {
                let vc =  makeUIAlertController(Message: "Error Occured ,Please Enter Again!")
                self.dismiss(animated: true, completion: nil)
                self.userName.text = ""
                self.password.text = ""
                
                
            }
        }
        
        
        
        
        
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
