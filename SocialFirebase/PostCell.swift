//
//  PostCell.swift
//  SocialFirebase
//
//  Created by crisser-01 on 06/01/2017.
//  Copyright © 2017 crisser-01. All rights reserved.
//

import UIKit
import Firebase

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

    func configureCell(post : Post, img : UIImage? = nil) {
        
        self.post = post
        
        caption.text = post.caption
        likesLbl.text = "\(post.likes)"
     
        if img != nil {
            self.postImg.image = img
        } else {
            
            let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
              ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                if error != nil {
                    print("Unable to download data from Firebase storage")
                }else {
                    print("Image downloaded from Firebase storage")
                    if let imageData = data {
                        if let img = UIImage(data: imageData) {
                            self.postImg.image = img
                            FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString)
                        }
                    }
                    
                }
                
                
              })
        }
    }
        
}
