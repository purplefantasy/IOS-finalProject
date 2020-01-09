//
//  profileController.swift
//  finalProject
//
//  Created by User11 on 2020/1/8.
//  Copyright © 2020 alice. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

class profileController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            account_text.text = user?.email?.description
            name_text.text = user?.email?.description
            set_text(a:name_text.text ?? "")
        }
        GraphRequest(graphPath: "me" ).start(completionHandler: {
        
            connection, result, error -> Void in
            if error == nil {
                
                Profile.loadCurrentProfile{(profile, error) in
                    let profile = profile
                    self.account_text.text = "FB" + (profile?.name ?? "")
                    self.name_text.text = profile?.name
                    self.set_text(a:profile?.userID ?? "")
                }
                
            }
            else {
                print("loginerror =\(error)")
            }
        })
        if let _ = GIDSignIn.sharedInstance()?.currentUser?.authentication {
            self.account_text.text = "Google "+(GIDSignIn.sharedInstance()?.currentUser.profile.name ?? "")
            self.name_text.text = GIDSignIn.sharedInstance()?.currentUser.profile.name
            set_text(a:GIDSignIn.sharedInstance()?.currentUser.profile.email ?? "")
            //self.img.ima
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBOutlet weak var account_text: UILabel!
    
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var name_text: UILabel!
    
    
    
    func set_text(a : String) {
        let db = Firestore.firestore()
        
        db.collection("簡介").whereField("user", isEqualTo: a)
            .getDocuments { (querySnapshot, error) in
            guard let querySnapshot = querySnapshot else {
               return
            }
                let document = querySnapshot.documents.first
                self.text.text = (document?.get("text") ?? "這個人很懶，這裡什麼都沒有...") as! String
                
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
