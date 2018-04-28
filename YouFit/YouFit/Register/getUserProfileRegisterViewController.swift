//
//  getUserProfileRegisterViewController.swift
//  YouFit
//
//  Created by Tapadyuti Maiti on 4/26/18.
//  Copyright © 2018 Tapadyuti Maiti. All rights reserved.
//

import UIKit
import HealthKit

class getUserProfileRegisterViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var weight: UITextField!
    @IBOutlet weak var height: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var birthday: UIDatePicker!
    
    var userAge:String?
    var biologicalSexLabel:Int?
    var bloodTypeLabel:Int?
    var bodyMassIndexLabel:Double?
    
    private let userHealthProfile = UserHealthProfile()
    
    override func viewWillAppear(_ animated: Bool) {
        loadAndDisplayAgeSexAndBloodType()
        loadAndDisplayMostRecentHeight()
        loadAndDisplayMostRecentWeight()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
      
    }

    @IBAction func doneButton(_ sender: CustomButton) {
        
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
            
        
            
        let user = UserBio(context: context)
            user.birthday = birthday.date
            user.height =   Double(height.text!)!
            user.nickName = name.text!
            user.weight = Double(weight.text!)!
            user.bmi = bmi
            user.bmiStatus = bmiStatus
            user.age = Int64(userHealthProfile.age!)
            user.bloodType =  Int64(bloodTypeLabel!)
            user.withUser?.email = currentUserLoggedIn?.email
            
            appDelegate.saveContext()
            
            
            
            
            
//        saveBodyMassIndexToHealthKit()
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
     ///////////////*******************************************************************
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
     ///////////////*******************************************************************
    private func loadAndDisplayAgeSexAndBloodType() {
        
        do {
            let userAgeSexAndBloodType = try ProfileDataStore.getAgeSexAndBloodType()
            userHealthProfile.age = userAgeSexAndBloodType.age
            userHealthProfile.biologicalSex = userAgeSexAndBloodType.biologicalSex
            userHealthProfile.bloodType = userAgeSexAndBloodType.bloodType
            updateLabels()
        } catch let error {
            self.displayAlert(for: error)
        }
    }
     ///////////////*******************************************************************
    private func updateLabels() {
        
        if let age = userHealthProfile.age {
            userAge = "\(age)"
        }
        
        if let biologicalSex = userHealthProfile.biologicalSex {
            biologicalSexLabel = biologicalSex.rawValue
            print("Sex")
            print(biologicalSex.rawValue)
        }
        
        if let bloodType = userHealthProfile.bloodType {
            bloodTypeLabel = bloodType.rawValue
            print("Blood Type")
            print(bloodType.rawValue)
        }
        
//        if let weight1 = userHealthProfile.weightInKilograms {
//            let weightFormatter = MassFormatter()
//            weightFormatter.isForPersonMassUse = true
//            weight.text = weightFormatter.string(fromKilograms: weight1)
//        }
        
//        if let height1 = userHealthProfile.heightInMeters {
//            let heightFormatter = LengthFormatter()
//            heightFormatter.isForPersonHeightUse = true
//            height.text = heightFormatter.string(fromMeters: height1)
//
//
//        }
        
        if let bodyMassIndex = userHealthProfile.bodyMassIndex {
            bodyMassIndexLabel = bodyMassIndex
            print("bmi form HealthApp")
            print(bodyMassIndexLabel)
        }
    }
     ///////////////*******************************************************************
    private func displayAlert(for error: Error) {
        
        let alert = UIAlertController(title: nil,
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "O.K.",
                                      style: .default,
                                      handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
     ///////////////*******************************************************************
    private func loadAndDisplayMostRecentHeight() {
        
        //1. Use HealthKit to create the Height Sample Type
        guard let heightSampleType = HKSampleType.quantityType(forIdentifier: .height) else {
            print("Height Sample Type is no longer available in HealthKit")
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: heightSampleType) { (sample, error) in
            
            guard let sample = sample else {
                
                if let error = error {
                    self.displayAlert(for: error)
                }
                
                return
            }
            
            //2. Convert the height sample to meters, save to the profile model,
            //   and update the user interface.
            let heightInMeters = sample.quantity.doubleValue(for: HKUnit.meter())
            self.height.text! = String(heightInMeters)
            self.updateLabels()
        }
    }
    
     ///////////////*******************************************************************
    
    private func loadAndDisplayMostRecentWeight() {
        
        guard let weightSampleType = HKSampleType.quantityType(forIdentifier: .bodyMass) else {
            print("Body Mass Sample Type is no longer available in HealthKit")
            return
        }
        
        ProfileDataStore.getMostRecentSample(for: weightSampleType) { (sample, error) in
            
            guard let sample = sample else {
                
                if let error = error {
                    self.displayAlert(for: error)
                }
                return
            }
            
            let weightInKilograms = sample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
            self.userHealthProfile.weightInKilograms = weightInKilograms
            self.weight.text! = String(weightInKilograms)
            self.updateLabels()
        }
    }
    
     ///////////////*******************************************************************
    
    private func saveBodyMassIndexToHealthKit() {
        
        guard let bodyMassIndex = userHealthProfile.bodyMassIndex else {
            displayAlert(for: ProfileDataError.missingBodyMassIndex)
            return
        }
        
        ProfileDataStore.saveBodyMassIndexSample(bodyMassIndex: bodyMassIndex,
                                                 date: Date())
    }
    
    ///////////////*******************************************************************
    
    private enum ProfileDataError: Error {
        
        case missingBodyMassIndex
        
        var localizedDescription: String {
            switch self {
            case .missingBodyMassIndex:
                return "Unable to calculate body mass index with available profile data."
            }
        }
    }
     ///////////////*******************************************************************

   

}
