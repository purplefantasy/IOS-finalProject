//
//  View1Controller.swift
//  finalProject
//
//  Created by User11 on 2019/11/27.
//  Copyright © 2019 alice. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn
import SwiftUI

class View1Controller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
            self.loginStatus.text = "一般帳號登入中"
            let user = Auth.auth().currentUser
            self.loginStatus2.text = user?.email?.description
        }
        GraphRequest(graphPath: "me" ).start(completionHandler: {
        
            connection, result, error -> Void in
            if error == nil {
                
                self.loginStatus.text = "FB登入中"
                Profile.loadCurrentProfile{(profile, error) in
                    let profile = profile
                    print("first_name",profile?.name)
                    self.loginStatus2.text = profile?.name
                }
                
            }
            else {
                print("loginerror =\(error)")
            }
        })
        if let _ = GIDSignIn.sharedInstance()?.currentUser?.authentication {
            self.loginStatus.text = "Google登入中"
            self.loginStatus2.text = GIDSignIn.sharedInstance()?.currentUser.profile.email
        }
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var loginStatus: UILabel!
    @IBOutlet weak var loginStatus2: UILabel!
    
    @IBSegueAction func swiftUI(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: LyricsView())
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func logout(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            try! Auth.auth().signOut()
            if Auth.auth().currentUser != nil {
                print("logout fail")
            } else {
                dismiss(animated: true, completion: nil)
            }
        }
        GraphRequest(graphPath: "me").start(completionHandler: {
                connection, result, error -> Void in
                if error == nil {
                    LoginManager().logOut()
                    self.dismiss(animated: true, completion: nil)
                }
        })
        
        GIDSignIn.sharedInstance().signOut()
        if let _ = GIDSignIn.sharedInstance()?.currentUser?.authentication {
          // Signed in
          print("google logout fail")
        } else {
          dismiss(animated: true, completion: nil)
        }
    }
}
    

