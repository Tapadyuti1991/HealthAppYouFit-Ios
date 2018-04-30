//
//  MeMainViewController.swift
//  YouFit
//
//  Created by Tapadyuti Maiti on 4/27/18.
//  Copyright © 2018 Tapadyuti Maiti. All rights reserved.
//

import UIKit

class MeMainViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var hiUser: UIView!
    @IBOutlet weak var userStreak: UIView!
    @IBOutlet weak var logWeight: UIView!
    @IBOutlet weak var bio: UIView!
    @IBOutlet weak var updatebio: UIView!
    
    @IBOutlet weak var imageDisplay: UIImageView!
    
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
        
        
        do{
            dataUser = try context.fetch(Users.fetchRequest())
            
            for e in dataUser{
                if(e.email == currentUserLoggedIn?.email){
                    for case let calCount as CalorieCounter in (e.withBio?.withCalorieCounter!)!{
                        let comp = NSCalendar.current.compare(Date(), to: calCount.curentTime!, toGranularity: .day)
                        if(comp.rawValue == 0){
                            var tempUserName:String = (e.withBio?.nickName)!
                            userGreeting.text = "Hi \(tempUserName)!"
                            var bmiDou:Double = (e.withBio?.bmi)!
                            bmiLabel.text = String(bmiDou)
                            bmiStatus.text =  e.withBio?.bmiStatus
                            var tempWei:Double = (e.withBio?.weight)!
                            UserCurrentWeight.text = String(tempWei)
                            imageDisplay.image = UIImage(data:(e.withBio?.userPic)!)!
                            
                        }
                        break
                    }
                }
                break
                
            }
        }
        catch{
            
        }
    }
    
    
    
    @IBAction func userProfile(_ sender: UITapGestureRecognizer) {
        
        print("Inside image Picker ")
        
        //pick media from photo library
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
 
        
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        appDelegate.saveContext()
    }
    
    @IBAction func updateBio(_ sender: UIButton) {
       performSegue(withIdentifier: "updateBio", sender: self)

    }
    
    
    @IBAction func stepperWeight(_ sender: UIStepper) {
        
        UserCurrentWeight.text = String(sender.value)
        
        
        do{
            dataUser = try context.fetch(Users.fetchRequest())
            
            for e in dataUser{
                if(e.email == currentUserLoggedIn?.email){
                    for case let calCount as CalorieCounter in (e.withBio?.withCalorieCounter!)!{
                        let comp = NSCalendar.current.compare(Date(), to: calCount.curentTime!, toGranularity: .day)
                        if(comp.rawValue == 0){
                            
                            e.withBio?.weight = Double(sender.value)
                            
                        }
                        break
                    }
                }
                break
                
            }
        }
        catch{
            
        }
 
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            else{
                fatalError("Expected a Dictionary containing an Image , but was provided the following : \(info)")
        }
        imageDisplay.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //Dismiss the picker  if the user canceled
        dismiss(animated: true, completion: nil)
    }
    
   
    
    
    
 
}
