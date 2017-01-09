//
//  Post.swift
//  SocialFirebase
//
//  Created by crisser-01 on 09/01/2017.
//  Copyright © 2017 crisser-01. All rights reserved.
//

import Foundation

class Post {
    
    private var _caption : String!
    private var _imageUrl : String!
    private var _likes : Int!
    private var _postKey : String!
    
    var caption : String {
        
        return _caption
    }
    
    var imageUrl : String {
        
        return _imageUrl
    }
    
    var likes : Int {
        if _likes == nil {
            _likes = 0
        }
        return _likes
    }
    
    var postKey : String {
        
        return _postKey
    }
    
    init(caption : String, imageUrl : String, likes : Int) {
        self._caption = caption
        self._imageUrl = imageUrl
        self._likes = likes
    }
    
    init(postKey : String, postData : Dictionary<String , AnyObject>) {
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String {
            
            self._caption = caption
        }
        
        if let imageUrl = postData["imageUrl"] as? String {
            
            self._imageUrl = imageUrl
        }
        
        if let likes = postData["likes"] as? Int {
            
            self._likes = likes
        }
        
    }
    
}

















