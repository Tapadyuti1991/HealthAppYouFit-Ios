//
//  updateBioViewController.swift
//  YouFit
//
//  Created by Tapadyuti Maiti on 4/28/18.
//  Copyright © 2018 Tapadyuti Maiti. All rights reserved.
//

import UIKit

class updateBioViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var birthday: UIDatePicker!
    
    
    

    @IBOutlet weak var imageDisplay: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        do{
            dataUser = try context.fetch(Users.fetchRequest())
            
            for e in dataUser{
                if(e.email == currentUserLoggedIn?.email){
                    for case let calCount as CalorieCounter in (e.withBio?.withCalorieCounter!)!{
                        let comp = NSCalendar.current.compare(Date(), to: calCount.curentTime!, toGranularity: .day)
                        if(comp.rawValue == 0){
                              name.text = e.withBio?.nickName
                            var tempw:Double = (e.withBio?.weight)!
                              weight.text = String(tempw)
                            var temph:Double = (e.withBio?.height)!
                              height.text = String(temph)
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
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            else{
                fatalError("Expected a Dictionary containing an Image , but was provided the following : \(info)")
        }
        
        print("Loading Image to the controller ")
        print(selectedImage)
        print("********")
        imageDisplay.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
 
    
    @IBAction func updateButtonimage(_ sender: UIButton) {
        print("Inside Gesture")
        //pick media from photo library
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
 
    
    
    
    @IBAction func updatebuttonAction(_ sender: CustomButton) {
        
        if (name.text! == "" || weight.text! == "" || height.text! == "" ){
            let vc = makeUIAlertController(Message: "Please Enter all the details ")
            self.present(vc, animated: true, completion: nil)
        }
            
            
            
        else{
            guard let intnum:Double = Double(weight.text!) else {
                let vc = makeUIAlertController(Message: "Please Enter Weight in Double ")
                self.present(vc, animated: true, completion: nil)
                return
            }
            guard let intHeight:Double = Double(height.text!) else {
                let vc = makeUIAlertController(Message: "Please Enter Height in Double ")
                self.present(vc, animated: true, completion: nil)
                return
            }
            
            
            
            //Gender
            var userGender:String  = "Male"
            if(gender.selectedSegmentIndex == 1){
                userGender = "Female"
            }
            //Birthday
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            var ubirthday:String = df.string(from:self.birthday.date)
            
            //Calculating present Age
            var todayDate:Date = Date()
            
            let comp = NSCalendar.current.compare(self.birthday.date, to: todayDate, toGranularity: .day)
            
            var weightU:Double = Double(weight.text!)!
            var heightU:Double = Double(height.text!)!
            //        var bmi = weightU * 703 / (heightU * heightU)
            var bmi = weightU / (heightU * heightU)
            
            var bmiStatus:String = getBmiStatus(bmi)
            print("BMi Status ")
            print(bmiStatus)
            
            // Puttin gin the Table
            var nameUs:String = name.text!
            var weightUs:String = weight.text!
            var heightUs:String = height.text!
            var ageUs:String = String(comp.rawValue)
            
            
            do{
                dataUser = try context.fetch(Users.fetchRequest())
                
                for e in dataUser{
                    if(e.email == currentUserLoggedIn?.email){
                        for case let calCount as CalorieCounter in (e.withBio?.withCalorieCounter!)!{
                            let comp = NSCalendar.current.compare(Date(), to: calCount.curentTime!, toGranularity: .day)
                            if(comp.rawValue == 0){
                                
                                e.withBio?.birthday = birthday.date
                                e.withBio?.height =   Double(height.text!)!
                                e.withBio?.nickName = name.text!
                                e.withBio?.weight = Double(weight.text!)!
                                e.withBio?.bmi = bmi
                                e.withBio?.bmiStatus = bmiStatus
                                let photo111 = imageDisplay.image
                                let imageexample = UIImageJPEGRepresentation(photo111!, 3)
                                e.withBio?.userPic = NSData(data: imageexample!) as Data
                                
                                
                                appDelegate.saveContext()
                                
                                let vc = makeUIAlertController(Message: "User Bio Updated Sucessfully!")
                                present(vc, animated: false, completion: nil)
                                
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
        
        
        
        
        
    }
    
    func  getBmiStatus(_ bmi:Double)->String
    {
        
        //        if bmi < 16 {
        //            return "Severe Thiness"
        //        }
        //
        //        if bmi > 16 && bmi < 17{
        //            return "Moderate Thiness"
        //        }
        //        if bmi > 17 && bmi < 18.5{
        //            return "Mild Thiness"
        //        }
        if bmi < 18.5{
            return "Thiness"
        }
        
        if bmi > 18.5 && bmi < 25{
            return "Normal"
        }
        
        if bmi > 25{
            return "Overweight"
        }
        
        //        if bmi > 25 && bmi < 30{
        //            return "Overweight"
        //        }
        //
        //        if bmi > 30 && bmi < 35{
        //            return "Mild Obese"
        //        }
        //        if bmi > 35 && bmi < 40{
        //            return "Moderate Obese"
        //        }
        //        if bmi > 40  {
        //            return "Severe Obese"
        //        }
        
        return "Normal"
        
    }
    @IBOutlet weak var updateButton: CustomButton!
    override func viewDidDisappear(_ animated: Bool) {
        appDelegate.saveContext()
        
    }
 

}
