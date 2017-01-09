//
//  RoundIt.swift
//  SocialFirebase
//
//  Created by crisser-01 on 05/01/2017.
//  Copyright © 2017 crisser-01. All rights reserved.
//

import UIKit

@IBDesignable
class RoundIt: UIButton {

    @IBInspectable var cornerRadious : CGFloat = 0.0 {
        
        didSet{
            
            layer.cornerRadius = cornerRadious
            layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
            layer.shadowOpacity = 0.8
            layer.shadowRadius = 4.0
            layer.shadowOffset = CGSize(width: 1.0, height: 2.0)
        }
        
    }
    
}
