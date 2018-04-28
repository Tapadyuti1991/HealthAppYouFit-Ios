//
//  SampleData.swift
//  YouFit
//
//  Created by Tapadyuti Maiti on 4/27/18.
//  Copyright © 2018 Tapadyuti Maiti. All rights reserved.
//

import Foundation



class SampleData{
    
//    static let sharedinstance = SampleData()
//
//    func network() {
//        // get everything
//    }
    
     func init2(){
        
        // Diet Plan :
        // 1.Severe Thiness      P; 412   C:  187  F: 66          C:1500  Brek:     Lunch        Snack          Dinner    Q  QT
        // 2.Moderate Thiness    P : 412   C:  187  F: 66          Brek:     Lunch        Snack          Dinner    Q  QT
        
        
        //3.Thiness         P :375    C: 187   F: 83       C:1650    Brek:     Lunch        Snack          Dinner
        //4.Normal               P : 300    C: 225  F: 100    c:1200       Brek:     Lunch        Snack          Dinner
        //5.Overweight           P : 450   C:  187  F:   50      C: 1800   Brek:     Lunch        Snack          Dinner
      
        var bmi:String = "Thiness"
        var targetCalorie:Int16?
        var proteinLeft:Int16?
        var carbLeft:Int16?
        var fatLeft:Int16?
        
        if(bmi == "Thiness"){
            targetCalorie = 3000
            proteinLeft = 300
            carbLeft = 225
            fatLeft = 200
            
        }
        if(bmi == "Normal"){
            targetCalorie = 2800
            proteinLeft = 300
            carbLeft = 225
            fatLeft = 200
            
        }
        
        if(bmi == "Overweight"){
            targetCalorie = 2000
            proteinLeft = 300
            carbLeft = 225
            fatLeft = 200
        }
        
            print("inside Create Sample User ")
            let currentuser = Users(context: context)
            currentuser.email = "sample.gmail.com"
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
                    user.withUser = currentuser
        
                    appDelegate.saveContext()
        
                    let  uCC = CalorieCounter(context: context)
                    uCC.targetCalorie = targetCalorie!
                    uCC.burntCalorie = 1200
                    uCC.eatCalorie = 500
                    uCC.carbLeft = 100
                    uCC.fatLeft = 50
                    uCC.proteinLeft = 100
                    uCC.waterCounter = 1.5
                    uCC.curentTime = Date()
        
        
                                    let uFood = Food(context:context)
                                    uFood.foodName = "Milk"
                                    uFood.calorie = 100
                                    uFood.carbs = 50
                                    uFood.fat = 50
                                    uFood.protein = 10
                                    uFood.rating = "A"
        
                                    let uLunch = Lunch(context: context)
                                    uLunch.calorieMax = uCC.targetCalorie/3 - 100
                                    uLunch.calorieMin = uCC.targetCalorie/3 + 100
                                    uLunch.quantity = 1
                                    uLunch.quantityType = "Glass"
                                    uLunch.withFood = uFood
        
                                    let uActualDiet = ActualDiet(context:context)
                                    uActualDiet.currentDate = Date()
                                    uActualDiet.withLunch = uLunch
        
                     uCC.withActualDiet = uActualDiet
                     uCC.withuserBio = user // activity remaninig
        
            currentuser.withBio = user
        
             appDelegate.saveContext()
            print("Sample user instantiated")
            //UserBio initiated // ********

    }
}
