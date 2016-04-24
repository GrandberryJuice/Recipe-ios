//
//  MaterialView.swift
//  Recipez
//
//  Created by KENNETH GRANDBERRY on 4/17/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit

class MaterialView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 2.0
        layer.shadowColor = UIColor(red: Shadow_Color, green: Shadow_Color, blue: Shadow_Color, alpha: 0.5).CGColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSizeMake(0.0, 2.0)
        
        
    }
}
