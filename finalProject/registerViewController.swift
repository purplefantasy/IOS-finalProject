//
//  registerViewController.swift
//  finalProject
//
//  Created by User11 on 2019/11/20.
//  Copyright © 2019 alice. All rights reserved.
//

import UIKit
import FirebaseAuth
class registerViewController: UIViewController {

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
    @IBAction func register(_ sender: Any) {
        Auth.auth().createUser(withEmail: account.text!, password: password.text!) { (result, error) in
                    
             guard let user = result?.user, error == nil else {
                 print(error?.localizedDescription)
                 return
             }
             print(user.email)
             self.dismiss(animated: true, completion: nil)
        }
    }
    @IBOutlet weak var account: UITextField!
    @IBOutlet weak var password: UITextField!
    
}
