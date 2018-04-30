//
//  SampleData.swift
//  YouFit
//
//  Created by Tapadyuti Maiti on 4/27/18.
//  Copyright © 2018 Tapadyuti Maiti. All rights reserved.
//

import Foundation

import CoreData
import UIKit

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
        
//            print("inside Create Sample User ")
//            let user = UserBio(context: context)
//            user.birthday = Date()
//            user.height =   1.3208
//            user.nickName = "Mike"
//            user.weight = 81.64
//            user.bmi = 47.9
//            user.bmiStatus = "Severe Obese"
//            user.age = 27
//            user.bloodType = 3
//
//            user.bloodType =  2
//            user.withUser?.email = "sample.gmail.com"
//            user.withUser?.password = "123"
//
//            appDelegate.saveContext()
//
//            let currentuser = Users(context: context)
//            currentuser.email = "sample.gmail.com"
//            currentuser.password = "123"
//
//            let  uCC = CalorieCounter(context: context)
//            uCC.targetCalorie = 2000
//            uCC.burntCalorie = 1200
//            uCC.eatCalorie = 2200
//            uCC.carbLeft = 225
//            uCC.fatLeft = 34
//            uCC.proteinLeft = 88
//            uCC.waterCounter = 2
//            uCC.curentTime = Date()
 
            
            //UserBio initiated // ********
        
        var bmi:String = "Thiness"
        var targetCalorie:Int16?
        var totalProtein:Int16?
        var totalcarb:Int16?
        var totalFat:Int16?
        
        if(bmi == "Thiness"){
            targetCalorie = 3000
            totalProtein = 300
            totalcarb = 225
            totalFat = 200
            
        }
        if(bmi == "Normal"){
            targetCalorie = 2800
            totalProtein = 300
            totalcarb = 225
            totalFat = 200
            
        }
        
        if(bmi == "Overweight"){
            targetCalorie = 2000
            totalProtein = 300
            totalcarb = 225
            totalFat = 200
        }
        
        print("Instantiating Food")
        let uFood = Food(context:context)
        uFood.foodName = "Milk"
        uFood.calorie = 100
        uFood.carbs = 50
        uFood.fat = 50
        uFood.protein = 10
        uFood.rating = "A"
        
        appDelegate.saveContext()
       
        let photo112 = UIImage(named: "shoe")
        let imageexample1 = UIImageJPEGRepresentation(photo112!, 3)
        uFood.foodImage = NSData(data: imageexample1!) as Data
        
        
        
        
        
        let beef1BreastFlank = Food(context:context)
        beef1BreastFlank.foodName = "Beef Brisket , no fat"
        beef1BreastFlank.calorie = 363
        beef1BreastFlank.carbs = 0
        beef1BreastFlank.fat = 19
        beef1BreastFlank.protein = 44
        beef1BreastFlank.rating = "A"
        
        
        
        print("Instntiate DietRecommendation")
        let DietReco1 = DietRecommended(context:context)
        DietReco1.dietId = 1
        DietReco1.dietName = "High Protein"
                let uLunch = Lunch(context: context)
                uLunch.quantity = 1
                uLunch.quantityType = "Piece"
                uLunch.calorieConsumed = uLunch.quantity * beef1BreastFlank.calorie
                uLunch.withFood = beef1BreastFlank
        
                let uBreakFast = Breakfast(context: context)
                uBreakFast.quantity = 1
                uBreakFast.quantityType = "Glass"
                uBreakFast.calorieConsumed = uFood.calorie * uBreakFast.quantity
        
        var breafFast = [uBreakFast]
        var lunch1 = [uLunch]
        
        DietReco1.withBreakFast = NSSet(array: breafFast)
        DietReco1.withLunch = NSSet(array:lunch1)
        
        

        
        
        print("inside Create Sample User ")
        
        let currentuser = Users(context: context)
        currentuser.email = "sample@gmail.com"
        currentuser.password = "123"
        
        let user = UserBio(context: context)
        user.birthday = Date()
                user.height =   1.3208
                user.nickName = "Mike"
                user.weight = 81.64
                user.bmi = 47.9
                user.bmiStatus = "Severe Obese"
                user.age = 27
                user.bloodType = 3
                user.totalFat = totalFat!
                user.totalCarb = totalcarb!
                user.totalProtein = totalProtein!
        
//        let photo111 = imageDisplay.image
//        let imageexample = UIImageJPEGRepresentation(photo111!, 3)
//        e.withBio?.userPic = NSData(data: imageexample!) as Data
        
        
        
                let photo111 = UIImage(named: "shoe")
                let imageexample = UIImageJPEGRepresentation(photo111!, 3)
                user.userPic = NSData(data: imageexample!) as Data
                user.withUser = currentuser
        
//        appDelegate.saveContext()
        
                            let  uCC = CalorieCounter(context: context)
                            uCC.targetCalorie = targetCalorie!
                            uCC.burntCalorie = 1200
                            uCC.eatCalorie = 500
                            uCC.carbLeft = 100
                            uCC.fatLeft = 50
                            uCC.proteinLeft = 100
                            uCC.waterCounter = 1.5
                            uCC.curentTime = Date()
        
        
                            let uActualDiet = ActualDiet(context:context)
                            uActualDiet.currentDate = Date()
                            uActualDiet.withLunch = uLunch
        
        
                            uCC.withActualDiet = uActualDiet
                            uCC.withuserBio = user // activity remaninig
        
                currentuser.withBio = user
        
            appDelegate.saveContext()
        do{
        dataUser = try context.fetch(Users.fetchRequest())
            for d in dataUser{
                print(d.email)
            }
        }
        catch{
            
        }
        
 
    }
}
