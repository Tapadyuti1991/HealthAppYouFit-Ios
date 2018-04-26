//
//  getUserProfileRegisterViewController.swift
//  YouFit
//
//  Created by Tapadyuti Maiti on 4/26/18.
//  Copyright © 2018 Tapadyuti Maiti. All rights reserved.
//

import UIKit

class getUserProfileRegisterViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var birthday: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }

    @IBAction func doneButton(_ sender: CustomButton) {
        
        if (name.text! == "" || weight.text! == "" || height.text! == "" ){
            let vc = makeUIAlertController(Message: "Please Enter all the details ")
            self.present(vc, animated: true, completion: nil)
        }
        
        else{
        
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
        var bmi = weightU * 703 / (heightU * heightU)
        
        var bmiStatus:String = getBmiStatus(bmi)
        print("BMi Status ")
        print(bmiStatus)
        
        // Puttin gin the Table
        var nameUs:String = name.text!
        var weightUs:String = weight.text!
        var heightUs:String = height.text!
        var ageUs:String = String(comp.rawValue)
        
        goToHome()
        
        }
        
       
    }
    
    func goToHome(){
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarViewController") as! tabBarViewController
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
//        popOverVC.didMove(toParentViewController: self)
    }
    
    func  getBmiStatus(_ bmi:Double)->String
    {
        
        if bmi < 16 {
            return "Severe Thiness"
        }
        
        if bmi > 16 && bmi < 17{
            return "Moderate Thiness"
        }
        if bmi > 17 && bmi < 18.5{
            return "Mild Thiness"
        }
        if bmi > 18.5 && bmi < 25{
            return "Normal"
        }
        if bmi > 25 && bmi < 30{
            return "Overweight"
        }
        
        if bmi > 30 && bmi < 35{
            return "Mild Obese"
        }
        if bmi > 35 && bmi < 40{
            return "Moderate Obese"
        }
        if bmi > 40  {
            return "Severe Obese"
        }
        
        return "Normal"
        
    }
    

   

}
