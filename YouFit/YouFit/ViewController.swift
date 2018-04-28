//
//  ViewController.swift
//  YouFit
//
//  Created by Tapadyuti Maiti on 4/16/18.
//  Copyright © 2018 Tapadyuti Maiti. All rights reserved.
//
//To do
//1. popup Modal
//2. 

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate,UITextFieldDelegate{

    @IBOutlet weak var pageControl: UIPageControl!
    @IBAction func loginButton(_ sender: UIBarButtonItem) {
        
        print("inside login button")
        performSegue(withIdentifier: "login", sender: self)
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
     var contentWidth:CGFloat = 0.0
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        funcInit()
        scrollView.delegate = self
        var aimList = ["Track Your Fitness","Make Fitness Fun","Eat As you Wish!"]
        for image in 0...2 {
            let imageToDisplay = UIImage(named: "\(image).png")
            let imageView = UIImageView(image: imageToDisplay)
            
            let xCoordinate = view.frame.midX + view.frame.width * CGFloat(image)
            
            contentWidth += view.frame.width
            
            
            
            let label = UILabel(frame: CGRect(x: xCoordinate-150, y: (scrollView.frame.height / 2)+10, width: 300, height: 40))

            label.font = UIFont.preferredFont(forTextStyle: .headline)
            label.textColor = UIColor.init(red: 255.0/255, green: 128.0/255, blue:0.0/255, alpha: 1.0)
//            label.center = CGPoint(x: 160, y: (scrollView.frame.height / 2)+101)
            label.adjustsFontForContentSizeCategory = true
            label.textAlignment = .center
//            label.font = UIFont.boldSystemFont(ofSize: 30.0)
            label.font = UIFont(name:"Marker Felt", size: 35.0)
            label.backgroundColor = UIColor.init(red: 0/255, green: 51.0/255, blue:0/255, alpha: 0.75)
            label.layer.masksToBounds = true
            label.layer.cornerRadius = 8.0
            
        
            label.text = aimList[image]
            scrollView.addSubview(imageView)
            scrollView.addSubview(label)
            
            imageView.frame = CGRect(x: xCoordinate - 50, y: (scrollView.frame.height / 2)-100, width: 100, height:100)
        }
        
        scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.frame.height)
        
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / CGFloat(view.frame.width))
        print(scrollView.contentOffset)
        
        
    }
    
    func funcInit(){
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
//        let currentuser = Users(context: context)
//        currentuser.email = "sample.gmail.com"
//        currentuser.password = "123"
        
        let user = UserBio(context: context)
//        user.birthday = Date()
//        user.height =   1.3208
//        user.nickName = "Mike"
//        user.weight = 81.64
//        user.bmi = 47.9
//        user.bmiStatus = "Severe Obese"
//        user.age = 27
//        user.bloodType = 3
        //        user.withUser = currentuser
        
        //    appDelegate.saveContext()
        //
        //    let  uCC = CalorieCounter(context: context)
        //    uCC.targetCalorie = targetCalorie!
        //    uCC.burntCalorie = 1200
        //    uCC.eatCalorie = 500
        //    uCC.carbLeft = 100
        //    uCC.fatLeft = 50
        //    uCC.proteinLeft = 100
        //    uCC.waterCounter = 1.5
        //    uCC.curentTime = Date()
        //
        //
        //    let uFood = Food(context:context)
        //    uFood.foodName = "Milk"
        //    uFood.calorie = 100
        //    uFood.carbs = 50
        //    uFood.fat = 50
        //    uFood.protein = 10
        //    uFood.rating = "A"
        //
        //    let uLunch = Lunch(context: context)
        //    uLunch.calorieMax = uCC.targetCalorie/3 - 100
        //    uLunch.calorieMin = uCC.targetCalorie/3 + 100
        //    uLunch.quantity = 1
        //    uLunch.quantityType = "Glass"
        //    //        uLunch.withFood = uFood
        //
        //    let uActualDiet = ActualDiet(context:context)
        //    uActualDiet.currentDate = Date()
        //        uActualDiet.withLunch = uLunch
        
        //        uCC.withActualDiet = uActualDiet
        //        uCC.withuserBio = user // activity remaninig
        
        //        currentuser.withBio = user
        
//        appDelegate.saveContext()
        print("Sample user instantiated")
        
        
    }

 

}

