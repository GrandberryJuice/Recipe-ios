//
//  CustomButton.swift
//  Recipez
//
//  Created by KENNETH GRANDBERRY on 4/22/16.
//  Copyright © 2016 KENNETH GRANDBERRY. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    @IBInspectable var inset: CGFloat = 0
    
    @IBInspectable var cornerRadius: CGFloat = 5.0 {
        didSet {
            setupVC()
        }
    }
    
    //setting the corner radius
    override func awakeFromNib() {
        self.layer.cornerRadius = 5.0
    }
    
    override func prepareForInterfaceBuilder() {
        setupVC()
    }
    
    
    func setupVC() {
        self.layer.cornerRadius = cornerRadius
        
    }

    
}
