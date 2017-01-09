//
//  FeedVC.swift
//  SocialFirebase
//
//  Created by crisser-01 on 06/01/2017.
//  Copyright © 2017 crisser-01. All rights reserved.
//

import UIKit
import Firebase
import SwiftKeychainWrapper

class FeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
    }

   
    @IBAction func signOutPressed(_ sender: Any) {
        
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("ID removed from keychain")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToSingIn", sender: nil)
       
    }

}


extension FeedVC : UITableViewDelegate ,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 2
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       // if let cell = tableView.dequeueReusableCell(withIdentifier: , for: <#T##IndexPath#>)
        
        return tableView.dequeueReusableCell(withIdentifier: "postCell") as! PostCell
    }
    
}










