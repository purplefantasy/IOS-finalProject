//
//  imgViewController.swift
//  finalProject
//
//  Created by User11 on 2020/1/8.
//  Copyright © 2020 alice. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage


class imgViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func Done(_ sender: Any) {
        uploadPhoto { (url) in
            if let url = url {
                let db = Firestore.firestore()
                let data: [String: Any] = ["photoUrl": url.absoluteString]
                var reference: DocumentReference?
                reference = db.collection("songs").addDocument(data: data, completion: { (error) in
                    if let error = error {
                        
                    } else {
                        print(reference?.documentID)
                    }
                    self.navigationController?.popViewController(animated: true)
                    
                })
                
            }
        }
    }
    
    @IBOutlet weak var photoButton: UIButton!
    
    func uploadPhoto(completion: @escaping (URL?) -> () ) {
        
        let fileReference = Storage.storage().reference().child(UUID().uuidString + ".jpg")
        
        
        if let data = photoButton.image(for: .normal)?.jpegData(compressionQuality: 0.9) {
            fileReference.putData(data, metadata: nil) { (_, error) in
                guard error == nil else {
                    print("upload error")
                    return
                }
                fileReference.downloadURL { (url, error) in
                    completion(url)
                }
            }
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
    @IBAction func img(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    }
    
}
extension imgViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        photoButton.setImage(image, for: .normal)
        
        
        dismiss(animated: true, completion: nil)
        
    }
}
