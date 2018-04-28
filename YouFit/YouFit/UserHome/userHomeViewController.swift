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
    
    
    @IBOutlet weak var lunchView: UIView!
    
    
    @IBOutlet weak var dinnerView: UIView!
    
    @IBOutlet weak var snacksView: UIView!
    
    
    
    @IBOutlet weak var addExerciseView: UIView!
    
    
    @IBOutlet weak var mealView: UIView!
    
    
    let shapeLayer1 = CAShapeLayer()
    let shapeLayer2 = CAShapeLayer()
    let shapeLayer3 = CAShapeLayer()
    
    override func viewWillAppear(_ animated: Bool) {
        calorieView.dropShadow()
        ClaorieDetailsView.dropShadow()
        trackDown.dropShadow()
        logWater.dropShadow()
        lunchView.dropShadow()
        dinnerView.dropShadow()
        snacksView.dropShadow()
        addExerciseView.dropShadow()
        mealView.dropShadow()
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        var center1 = calorieLeftView.center
        var center2 = eaternCalorieView.center
        var center3 = burntCalorieView.center
        
        let trackLayer1 = CAShapeLayer()
        let trackLayer2 = CAShapeLayer()
        let trackLayer3 = CAShapeLayer()
        
        var radius1:CGFloat  = 30
        var radius2:CGFloat = 15
        var radius3:CGFloat = 15
        
        
        
        var calorie1Percent:CGFloat  = 0.5
        var calorie2Percent:CGFloat  = 0.7
        var calorie3Percent:CGFloat  = 0.9
        
        let circularPath1 = UIBezierPath(arcCenter: center1, radius: radius1, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi * calorie1Percent, clockwise: true)
        let circularPath2 = UIBezierPath(arcCenter: center2, radius: radius2, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi * calorie2Percent, clockwise: true)
        let circularPath3 = UIBezierPath(arcCenter: center3, radius: radius3, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi * calorie3Percent, clockwise: true)
        
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
        animateCalorie1()
        animateCalorie2()
        animateCalorie3()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
