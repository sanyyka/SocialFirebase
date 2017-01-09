//
//  RoundImage.swift
//  SocialFirebase
//
//  Created by crisser-01 on 09/01/2017.
//  Copyright © 2017 crisser-01. All rights reserved.
//

import UIKit


class RoundImage: UIImageView {

    override func layoutSubviews() {
        
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }

}
