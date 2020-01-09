//
//  addtextViewController.swift
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

class addtextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var text: UITextField!
    
    @IBAction func ok(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            s_text(a:user?.email?.description ?? "")
        }
        GraphRequest(graphPath: "me" ).start(completionHandler: {
        
            connection, result, error -> Void in
            if error == nil {
                
                Profile.loadCurrentProfile{(profile, error) in
                    let profile = profile
                    self.s_text(a:profile?.userID ?? "")
                }
                
            }
            else {
                print("loginerror =\(error)")
            }
        })
        if let _ = GIDSignIn.sharedInstance()?.currentUser?.authentication {
            s_text(a:GIDSignIn.sharedInstance()?.currentUser.profile.email ?? "")
        }
       
    }
    
    
    func s_text(a:String){
        let db = Firestore.firestore()
        let data: [String: Any] = ["user": a ,"text": text.text]
        db.collection("簡介").whereField("user", isEqualTo: a).getDocuments { (snapshots, error) in
            
            if(snapshots!.documents.count>0){
                for doc in snapshots!.documents {
                   
                    db.collection("簡介").document(doc.documentID).delete { (error) in
                        
                        
                    }
                    
                }
            }
            var reference: DocumentReference?
             reference = db.collection("簡介").addDocument(data: data, completion: { (error) in
                if let error = error {
                    
                } else {
                    print(reference?.documentID)
                }
                let rootController = self.navigationController?.viewControllers.first
                self.navigationController?.popViewController(animated: true)
            })
            
            
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
