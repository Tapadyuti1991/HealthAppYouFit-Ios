//
//  userHomeViewController.swift
//  YouFit
//
//  Created by Tapadyuti Maiti on 4/26/18.
//  Copyright © 2018 Tapadyuti Maiti. All rights reserved.
//

import UIKit

class userHomeViewController: UIViewController {
    
    @IBOutlet weak var calorieView: UIView!
    @IBOutlet weak var calorieLeftView: UIView!
    @IBOutlet weak var eaternCalorieView: UIView!
    @IBOutlet weak var burntCalorieView: UIView!
    @IBOutlet weak var calorieLeftValueLabel: UILabel!
    @IBOutlet weak var burntCalorieLabel: UILabel!
    @IBOutlet weak var eatenCalorieLabel: UILabel!
    
    
    @IBOutlet weak var ClaorieDetailsView: UIView!
    @IBOutlet weak var carbsProgress: UIProgressView!
    @IBOutlet weak var fatProgress: UIProgressView!
    @IBOutlet weak var proteinProgress: UIProgressView!
    @IBOutlet weak var carbsProgressLabel: UILabel!
    @IBOutlet weak var proteinProgressLabel: UILabel!
    @IBOutlet weak var fatProgressLabel: UILabel!
    
    
    @IBOutlet weak var trackDown: UIView!
    
    
    @IBOutlet weak var logWater: UIView!
    
    @IBOutlet weak var waterStepperLabel: UILabel!
    
    @IBOutlet weak var lunchView: UIView!
    
    @IBOutlet weak var lunchRecom: UIButton!
    
    @IBOutlet weak var dinnerView: UIView!
    @IBOutlet weak var dinnerRecomButto: UIButton!
    
    @IBOutlet weak var snacksView: UIView!
    
    @IBOutlet weak var snackRecomButt: UIButton!
    
    
    @IBOutlet weak var addExerciseView: UIView!
    
    @IBOutlet weak var addExcersiceRecomButt: UIButton!
    
    @IBOutlet weak var mealView: UIView!
    
    
    let shapeLayer1 = CAShapeLayer()
    let shapeLayer2 = CAShapeLayer()
    let shapeLayer3 = CAShapeLayer()
    
    var currentCalCounter:CalorieCounter?
    
    override func viewWillAppear(_ animated: Bool) {
        print("View will appear")
        
        calorieView.dropShadow()
        ClaorieDetailsView.dropShadow()
        trackDown.dropShadow()
        logWater.dropShadow()
        lunchView.dropShadow()
        dinnerView.dropShadow()
        snacksView.dropShadow()
        addExerciseView.dropShadow()
        mealView.dropShadow()
        
        var calorie1Percent:CGFloat?
        var calorie2Percent:CGFloat?
        var calorie3Percent:CGFloat?
        
        print("\(currentUserLoggedIn?.email) logged in ")
        var userBio:UserBio = (currentUserLoggedIn?.withBio)!
        var CalorieCountSet = userBio.withCalorieCounter
        
        var currentUsedfat = 0
        var currentUsedProtein = 0
        var currentUsedCarb = 0
        var currentWaterCounter = 0.0
        
        do{
            dataUser = try context.fetch(Users.fetchRequest())
            
            for e in dataUser{
                if(e.email == currentUserLoggedIn?.email){
                         for case let calCount as CalorieCounter in (e.withBio?.withCalorieCounter!)!{
                            let comp = NSCalendar.current.compare(Date(), to: calCount.curentTime!, toGranularity: .day)
                            if(comp.rawValue == 0){
                                calorieLeftValueLabel.text = "\(calCount.targetCalorie) KCal Left"
                                calorie1Percent = CGFloat(calCount.burntCalorie/calCount.targetCalorie)
                                
                                eatenCalorieLabel.text = "\(calCount.eatCalorie)KCal"
                                calorie2Percent = CGFloat(calCount.eatCalorie/calCount.targetCalorie)
                                
                                burntCalorieLabel.text = "\(calCount.burntCalorie)KCal"
                                calorie3Percent = CGFloat(calCount.burntCalorie/calCount.targetCalorie)
                                
                                currentUsedfat = Int(calCount.fatLeft)
                                currentUsedProtein = Int(calCount.proteinLeft)
                                currentUsedCarb = Int(calCount.carbLeft)
                                
                                currentWaterCounter = Double(calCount.waterCounter)
                                
                                currentCalCounter = calCount
//                                lunchRecom.tit = "Recommended 400-545 Kcal"
                            }
                            break
                        }
                }
                break
                
            }
        }
            catch{
                
            }
        
        carbsProgressLabel.text = "\(Int(userBio.totalCarb) - currentUsedCarb) Left"
        proteinProgressLabel.text = "\(Int(userBio.totalProtein) - currentUsedProtein) Left"
        fatProgressLabel.text = "\(Int(userBio.totalFat) - currentUsedfat) Left"
        
        carbsProgress.progress = Float(currentUsedCarb)
        proteinProgress.progress = Float(currentUsedProtein)
        fatProgress.progress = Float(currentUsedfat)

 
        var center1 = calorieLeftView.center
        var center2 = eaternCalorieView.center
        var center3 = burntCalorieView.center
        
        let trackLayer1 = CAShapeLayer()
        let trackLayer2 = CAShapeLayer()
        let trackLayer3 = CAShapeLayer()
        
        var radius1:CGFloat  = 30
        var radius2:CGFloat = 15
        var radius3:CGFloat = 15
        
        
        
      
        
        let circularPath1 = UIBezierPath(arcCenter: center1, radius: radius1, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi * calorie1Percent!, clockwise: true)
        let circularPath2 = UIBezierPath(arcCenter: center2, radius: radius2, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi * calorie2Percent!, clockwise: true)
        let circularPath3 = UIBezierPath(arcCenter: center3, radius: radius3, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi * calorie3Percent!, clockwise: true)
        
        let trackPath1 = UIBezierPath(arcCenter: center1, radius: radius1, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi , clockwise: true)
        let trackPath2 = UIBezierPath(arcCenter: center2, radius: radius2, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi , clockwise: true)
        let trackPath3 = UIBezierPath(arcCenter: center3, radius: radius3, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi , clockwise: true)
        
        
        trackLayer1.path = trackPath1.cgPath
        trackLayer2.path = trackPath2.cgPath
        trackLayer3.path = trackPath3.cgPath
        
        trackLayer1.strokeColor = UIColor.init(red: 255.0/255, green: 255.0/255, blue:209.0/255, alpha: 1.0).cgColor
        trackLayer1.lineWidth = 5
        trackLayer1.fillColor = UIColor.clear.cgColor
        trackLayer1.lineCap = kCALineCapRound
        calorieLeftView.layer.addSublayer(trackLayer1)
        shapeLayer1.path = circularPath1.cgPath
        shapeLayer1.strokeColor = UIColor.init(red: 255.0/255, green: 128.0/255, blue:0.0/255, alpha: 1.0).cgColor
        shapeLayer1.lineWidth = 5
        shapeLayer1.fillColor = UIColor.clear.cgColor
        shapeLayer1.lineCap = kCALineCapRound
        shapeLayer1.strokeEnd = 0
        calorieLeftView.layer.addSublayer(shapeLayer1)
        
        trackLayer2.strokeColor = UIColor.init(red: 255.0/255, green: 255.0/255, blue:209.0/255, alpha: 1.0).cgColor
        trackLayer2.lineWidth = 5
        trackLayer2.fillColor = UIColor.clear.cgColor
        trackLayer2.lineCap = kCALineCapRound
        eaternCalorieView.layer.addSublayer(trackLayer2)
        shapeLayer2.path = circularPath2.cgPath
        shapeLayer2.strokeColor = UIColor.init(red: 255.0/255, green: 128.0/255, blue:0.0/255, alpha: 1.0).cgColor
        shapeLayer2.lineWidth = 3
        shapeLayer2.fillColor = UIColor.clear.cgColor
        shapeLayer2.lineCap = kCALineCapRound
        shapeLayer2.strokeEnd = 0
        eaternCalorieView.layer.addSublayer(shapeLayer2)
        
        trackLayer3.strokeColor = UIColor.init(red: 255.0/255, green: 255.0/255, blue:209.0/255, alpha: 1.0).cgColor
        trackLayer3.lineWidth = 5
        trackLayer3.fillColor = UIColor.clear.cgColor
        trackLayer3.lineCap = kCALineCapRound
        burntCalorieView.layer.addSublayer(trackLayer3)
        shapeLayer3.path = circularPath3.cgPath
        shapeLayer3.strokeColor = UIColor.init(red: 255.0/255, green: 128.0/255, blue:0.0/255, alpha: 1.0).cgColor
        shapeLayer3.lineWidth = 2.5
        shapeLayer3.fillColor = UIColor.clear.cgColor
        shapeLayer3.lineCap = kCALineCapRound
        shapeLayer3.strokeEnd = 0
        burntCalorieView.layer.addSublayer(shapeLayer3)
        
        
        
        
        animateCalorie1()
        animateCalorie2()
        animateCalorie3()
        
        
        
        
        
        
        
        
    }
    
    
    
    func animateCalorie1( ) {
        print("Attempting to animate stroke")
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer1.add(basicAnimation, forKey: "urSoBasic")
    }
    func animateCalorie2( ) {
        print("Attempting to animate stroke")
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer2.add(basicAnimation, forKey: "urSoBasic")
    }
    func animateCalorie3( ) {
        print("Attempting to animate stroke")
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer3.add(basicAnimation, forKey: "urSoBasic")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func waterStepper(_ sender: UIStepper) {
        waterStepperLabel.text =  String(sender.value)
        currentCalCounter?.waterCounter = sender.value
        
        do{
            dataUser = try context.fetch(Users.fetchRequest())
            
            for e in dataUser{
                if(e.email == currentUserLoggedIn?.email){
                    for case let calCount as CalorieCounter in (e.withBio?.withCalorieCounter!)!{
                        let comp = NSCalendar.current.compare(Date(), to: calCount.curentTime!, toGranularity: .day)
                        if(comp.rawValue == 0){
                            calCount.waterCounter = sender.value
                        }
                    }
                }
            }
            
                    
        }
        catch{
            
        }
        
        appDelegate.saveContext()
        
 
        
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        appDelegate.saveContext()
    }
    

   

    
}
