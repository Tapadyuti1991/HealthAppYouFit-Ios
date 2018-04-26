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

 

}

