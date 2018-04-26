//
//  CustomButton.swift
//  YouFit
//
//  Created by Tapadyuti Maiti on 4/26/18.
//  Copyright © 2018 Tapadyuti Maiti. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton: UIButton {
    @IBInspectable var borderThiickness:CGFloat = 0.0{
        didSet{
            self.layer.borderWidth = borderThiickness
        }
    }
    
    @IBInspectable var borderColor = UIColor.black{
        didSet{
            self.layer.borderColor  = borderColor.cgColor
        }
    }
    @IBInspectable var borderCorner: CGFloat = 0.0 {
        didSet{
            self.layer.cornerRadius = borderCorner
        }
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
