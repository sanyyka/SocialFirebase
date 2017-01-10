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
    @IBOutlet weak var postImageAdd: RoundImage!
    @IBOutlet weak var captionField: UITextField!
    
    var imagePicker : UIImagePickerController!
    var posts = [Post]()
    static var imageCache : NSCache<NSString, UIImage> = NSCache()
    var imageSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            
            self.posts = []
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("Snap : \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                    }
                }
            }
            self.tableView.reloadData()
            
        })
        
    }

   
    @IBAction func signOutPressed(_ sender: Any) {
        
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("ID removed from keychain")
        try! FIRAuth.auth()?.signOut()
        performSegue(withIdentifier: "goToSingIn", sender: nil)
       
    }
    
    @IBAction func postBtnPressed(_ sender: Any) {
        
        guard  let caption = captionField.text , captionField.text != "" else {
            print("You have to add a caption to the post")
            return
        }
        
        guard let img = postImageAdd.image, imageSelected == true else {
            print("An image must be selected")
            return
        }
        
        if let imageData = UIImageJPEGRepresentation(img, 0.2) {
            
            let imgUid = NSUUID().uuidString
            let metadata = FIRStorageMetadata()
            metadata.contentType = "image/jpeg"
            
            DataService.ds.REF_TO_STORAGE_POSTS.child(imgUid).put(imageData, metadata: metadata) { (metadata, error) in
                
                if error != nil {
                    print("Unable to upload image to Firebase storage.")
                } else {
                    print("The image was updated to Firebase storage succesfully.")
                    let downloadUrl = metadata?.downloadURL()?.absoluteString
                    
                    if let url = downloadUrl {
                        self.postToFirebase(imgUrl: url)
                    }
                }
            }
        }
        
    }
    
    func postToFirebase(imgUrl : String) {
        
        let postDict : Dictionary<String , Any>  = [
        "caption": captionField.text!,
        "imageUrl": imgUrl ,
        "likes":0
        ]
        
        let refToPost = DataService.ds.REF_POSTS.childByAutoId()
        refToPost.setValue(postDict)
        
        captionField.text = ""
        postImageAdd.image = UIImage(named: "add-image")
        imageSelected = false
        
        
    }

    @IBAction func addImagePressed(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
}


extension FeedVC : UITableViewDelegate ,UITableViewDataSource ,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return posts.count
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            
            if let img = FeedVC.imageCache.object(forKey: post.imageUrl as NSString) {
                
                cell.configureCell(post: post, img: img )
                return cell
            } else {
                cell.configureCell(post: post)
                return cell
            }
       
        } else {
            return UITableViewCell()
        }
        
}
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            postImageAdd.image = image
            imageSelected = true
            
        }else {
            
            print("A valid image was not selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
        
    }

}
