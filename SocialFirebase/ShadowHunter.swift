//
//  ShadowHunter.swift
//  SocialFirebase
//
//  Created by crisser-01 on 05/01/2017.
//  Copyright © 2017 crisser-01. All rights reserved.
//

import UIKit

class ShadowHunter: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.shadowColor = UIColor(red: SHADOW_GRAY, green: SHADOW_GRAY, blue: SHADOW_GRAY, alpha: 0.6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 10.0
        layer.shadowOffset = CGSize(width: 0.5, height: 10.0)
        layer.cornerRadius = 2
        
    }

}
