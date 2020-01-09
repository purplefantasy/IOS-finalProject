//
//  ViewController.swift
//  finalProject
//
//  Created by User11 on 2019/11/20.
//  Copyright © 2019 alice. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

class ViewController: UIViewController{
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let user = Auth.auth().currentUser {
            print("\(user.email) login")
            self.performSegue(withIdentifier: "main", sender: nil)
        } else {
            print("not login")
        }
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        // Automatically sign in the user.
        if (AccessToken.current) != nil{
            fetchProfile()
        }
        else{
            print("fb not login")
        }
        
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        if let _ = GIDSignIn.sharedInstance()?.currentUser?.authentication {
            // Get new token from google and send to server
            self.performSegue(withIdentifier: "main", sender: nil)
        }
        else {
            // present login screen here
            print("google not login")
        }
    }
    

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
            
            if error != nil{
                print(error)
                return
            }else{
                print("123")
                print(user.userID)
                print(user.profile.email)
                print(user.profile.imageURL(withDimension: 400))
            }
    }
    
    
    
    
    @IBAction func FBlogin(_ sender: Any) {
        let manager = LoginManager()
        manager.logIn(permissions: ["public_profile", "email", "user_friends"], from: self) { (result, error) in
            if error != nil{
                print("longinerror =\(error)")
                return
            }
            self.fetchProfile()
        }
    }
    func fetchProfile(){
        GraphRequest(graphPath: "me").start(completionHandler: {
            connection, result, error -> Void in
            if error != nil {
                print("登入失敗")
                print("longinerror =\(error)")
            } else {
                if let resultNew = result as? [String:Any]{
                    print("成功登入")
                    self.performSegue(withIdentifier: "main", sender: nil)
                }
            }
        })
    }
}

