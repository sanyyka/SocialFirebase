//
//  PostCell.swift
//  SocialFirebase
//
//  Created by crisser-01 on 06/01/2017.
//  Copyright © 2017 crisser-01. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var profileImg : UIImageView!
    @IBOutlet weak var usernameLbl : UILabel!
    @IBOutlet weak var postImg : UIImageView!
    @IBOutlet weak var caption : UITextView!
    @IBOutlet weak var likesLbl : UILabel!
    
    var post : Post!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureCell(post : Post) {
        
        self.post = post
        
        caption.text = post.caption
        likesLbl.text = "\(post.likes)"
      //  postImg.image = UIImage(named: post.imageUrl)
        
    }

}
