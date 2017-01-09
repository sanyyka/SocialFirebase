//
//  SignInVC.swift
//  SocialFirebase
//
//  Created by crisser-01 on 05/01/2017.
//  Copyright © 2017 crisser-01. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper


class SignInVC: UIViewController {

    @IBOutlet weak var emailAddressLbl: UITextField!
    @IBOutlet weak var passwordLbl: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            
            performSegue(withIdentifier: "goToFeed", sender: nil)
        }
        
    }

    @IBAction func facebookButtonPressed(_ sender: Any) {
        
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if error != nil {
                print("Flash: Unable to authentificate with facebook - \(error)")
            }else if result?.isCancelled == true {
                print("Flash: User canceled facebook authentification ")
            }else {
                print("Flash: Succesfully authentificated with facebook")
                
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
                
            }
            
        }
        
        
    }
    
    func firebaseAuth(_ credential : FIRAuthCredential){
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            
            if error != nil {
                print("Flash:Unable to authentificate with firebase - \(error) ")
            }else {
                print("Flash:Succesfully authentificated with firebase")
                
                if let user = user {
                    
                    let userData = ["provider": credential.provider]
                    self.completeSignIn(user.uid, userData : userData)
                }
            }
            
            
        })
        
    }

    @IBAction func signInPressed(_ sender: Any) {
        
        if let email = emailAddressLbl.text, let password = passwordLbl.text {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                
                if error == nil {
                    print("Flash:User authentificated with firebase")
                    if let user = user {
                        let userData = ["provider" : user.providerID]
                        self.completeSignIn(user.uid, userData : userData)
                    }
                    
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        
                        if error != nil {
                            print("Flash:User authentificated with firebase using email")
                        }else {
                            print("Flash:Succesfully authentificated with Firebase")
                            if let user = user {
                                let userData = ["provider" : user.providerID]
                                self.completeSignIn(user.uid, userData : userData)
                                
                            }
                        }
                    })
                }
                
            })
        }
        
    }
    
    func completeSignIn(_ id : String, userData : Dictionary<String , String>){
        
        DataService.ds.createFirebaseDBUser(uid: id, userData: userData)
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
        print("user id \(id)")
        performSegue(withIdentifier: "goToFeed", sender: nil)
       
    }
    
}
















