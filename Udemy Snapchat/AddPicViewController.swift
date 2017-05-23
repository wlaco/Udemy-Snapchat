//
//  AddPicViewController.swift
//  Udemy Snapchat
//
//  Created by Will Laco on 5/21/17.
//  Copyright © 2017 Will Laco. All rights reserved.
//

import UIKit
import Firebase

class AddPicViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var snapImageView: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var snapNameTextField: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        snapImageView.image = image
        
        snapImageView.backgroundColor = UIColor.clear
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        
        imagePicker.sourceType = .savedPhotosAlbum
        
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        
        nextButton.isEnabled = false
        
        let imagesFolder = Storage.storage().reference().child("images")
        
        let imageData = UIImageJPEGRepresentation(snapImageView.image!, 0.01)!
        
        imagesFolder.child("\(NSUUID().uuidString).jpg").putData(imageData, metadata: nil) { (metadata, error) in
            if error != nil {
                print("We had an error:\(error!)")
            } else {
                
                print(metadata?.downloadURL() ?? "")
                
                self.performSegue(withIdentifier: "selectUserSegue", sender: nil)            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
