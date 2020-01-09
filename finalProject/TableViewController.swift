//
//  TableViewController.swift
//  finalProject
//
//  Created by User11 on 2019/12/18.
//  Copyright © 2019 alice. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

class TableViewController: UITableViewController {

    var files = [Files]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        db.collection("留言").order(by: "index", descending:true ).addSnapshotListener { (querySnapshot, error) in
            guard let querySnapshot = querySnapshot else {
               return
            }
            self.files = querySnapshot.documents.map({
                Files(dic: $0.data())
            })
            self.tableView.reloadData()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of rows
        return files.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath)
        let file = files[indexPath.row]
        print("123")
        cell.textLabel?.text = file.text
        cell.detailTextLabel?.text = file.name
        // Configure the cell...

        return cell
    }

    @IBOutlet weak var textTextField: UITextField!
    
    var name :String?
    
    @IBAction func send(_ sender: Any) {
        
        
        
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            name = user?.email?.description
            sending()
        }
        GraphRequest(graphPath: "me" ).start(completionHandler: {
        
            connection, result, error -> Void in
            if error == nil {
                Profile.loadCurrentProfile{(profile, error) in
                    let profile = profile
                    print("first_name123",profile?.name)
                    self.name = profile?.name
                    print("first_name123",self.name)
                    self.sending()
                }
                
            }
            else {
                print("longinerror =\(error)")
            }
        })
        if let _ = GIDSignIn.sharedInstance()?.currentUser?.authentication {
            name = GIDSignIn.sharedInstance()?.currentUser.profile.name
            sending()
        }
        
        
    }
    
    func sending(){
        let db = Firestore.firestore()
        
        if(textTextField.text==""){
            return
        }
        var reference: DocumentReference?
        var num = 0
        db.collection("留言").getDocuments { (snapshots, error) in
            num = snapshots!.documents.count
            let data: [String: Any] = ["name": self.name, "text": self.textTextField.text!, "index":num]
            reference = db.collection("留言").addDocument(data: data, completion: { (error) in
                if let error = error {
                    
                } else {
                    print(reference?.documentID)
                }
                self.textTextField.text=""
            })
            
        }
        
        
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
