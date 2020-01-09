//
//  LoginViewController.swift
//  finalProject
//
//  Created by User11 on 2019/11/20.
//  Copyright © 2019 alice. All rights reserved.
//

import UIKit
import FirebaseAuth
class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func login(_ sender: Any) {
        Auth.auth().signIn(withEmail: account.text!, password: password.text!) { [weak self] (result, error) in
                    guard let self = self else { return }
                    guard error == nil else {
                        print(error?.localizedDescription)
                        return
                    }
            
            let rootController = self.navigationController?.viewControllers.first
            self.navigationController?.popViewController(animated: false)
            rootController?.performSegue(withIdentifier: "main", sender: nil)
            
//            let presentingViewController = self.presentingViewController
//            self.dismiss(animated: true) {
//                presentingViewController?.performSegue(withIdentifier: "main", sender: nil)
//            }
        }
    }
    @IBOutlet weak var account: UITextField!
    @IBOutlet weak var password: UITextField!
    
}
