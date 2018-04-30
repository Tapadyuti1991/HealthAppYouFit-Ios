//
//  FoodViewCell.swift
//  YouFit
//
//  Created by Tapadyuti Maiti on 4/28/18.
//  Copyright © 2018 Tapadyuti Maiti. All rights reserved.
//

import Foundation
import UIKit

class FoodViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var carbs: UILabel!
    @IBOutlet weak var fat: UILabel!
    @IBOutlet weak var protein: UILabel!
     @IBOutlet weak var calorie: UILabel!
    @IBOutlet weak var imagefood: UIImageView!
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
       super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
