//
//  SampleData.swift
//  YouFit
//
//  Created by Tapadyuti Maiti on 4/27/18.
//  Copyright © 2018 Tapadyuti Maiti. All rights reserved.
//

import Foundation



class SampleData{
    
    static let sharedinstance = SampleData()
    
    func network() {
        // get everything
    }
    
    private init(){
        
        // Diet Plan :
        // 1.Severe Thiness      P; 412   C:  187  F: 66          C:1500  Brek:     Lunch        Snack          Dinner    Q  QT
        // 2.Moderate Thiness    P : 412   C:  187  F: 66          Brek:     Lunch        Snack          Dinner    Q  QT
        //3.Mild Thiness         P :375    C: 187   F: 83       C:1650    Brek:     Lunch        Snack          Dinner
        //4.Normal               P : 300    C: 225  F: 100    c:1200       Brek:     Lunch        Snack          Dinner
        //5.Overweight           P : 450   C:  187  F:   50      C: 1800   Brek:     Lunch        Snack          Dinner
        //6.
        //
        //
        //
        //
        //
        //
        //
        //
        //
        //
        
            print("inside Create Sample User ")
            let user = UserBio(context: context)
            user.birthday = Date()
            user.height =   1.3208
            user.nickName = "Mike"
            user.weight = 81.64
            user.bmi = 47.9
            user.bmiStatus = "Severe Obese"
            user.age = 27
            user.bloodType = 3
        
        
        
        
            user.bloodType =  2
            user.withUser?.email = "sample.gmail.com"
            user.withUser?.password = "123"
            
            appDelegate.saveContext()
        
        
        
            let currentuser = Users(context: context)
            currentuser.email = "sample.gmail.com"
            currentuser.password = "123"
        
            let  uCC = CalorieCounter(context: context)
            uCC.targetCalorie = 2000
            uCC.burntCalorie = 1200
            uCC.eatCalorie = 2200
            uCC.carbLeft = 225
            uCC.fatLeft = 34
            uCC.proteinLeft = 88
            uCC.waterCounter = 2
            uCC.curentTime = Date()
        
            
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
            
            //UserBio initiated // ********
            
        
       
        
            
            
        
            
      
        
        
        
    }
}
