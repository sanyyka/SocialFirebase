//
//  DataService.swift
//  SocialFirebase
//
//  Created by crisser-01 on 09/01/2017.
//  Copyright © 2017 crisser-01. All rights reserved.
//

import Foundation
import Firebase

let DATA_BASE = FIRDatabase.database().reference()
let STORAGE_BASE = FIRStorage.storage().reference()

class DataService {
    
    static let ds = DataService()
    
    //DB references
    private var _REF_DB = DATA_BASE
    private var _REF_POSTS = DATA_BASE.child("posts")
    private var _REF_USERS = DATA_BASE.child("users")
    
    //Storage references
    
    private var _REF_TO_STORAGE_POSTS = STORAGE_BASE.child("post-pics")
    
    var REF_TO_STORAGE_POSTS :FIRStorageReference {
        
        return _REF_TO_STORAGE_POSTS
    }
    
    var REF_DB : FIRDatabaseReference {
        
        return _REF_DB
    }
    
    var REF_POSTS : FIRDatabaseReference {
        
        return _REF_POSTS
    }
    
    var REF_USERS : FIRDatabaseReference {
        
        return _REF_USERS
    }
    
    func createFirebaseDBUser(uid : String , userData : Dictionary<String, String>) {
        
        REF_USERS.child(uid).updateChildValues(userData)
      
    }
    
    
    
}
