//
//  SignInViewController.swift
//  Udemy Snapchat
//
//  Created by Will Laco on 5/17/17.
//  Copyright © 2017 Will Laco. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func swagifyTapped(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error)
                    in
                    print("We tried to create a user")
                    
                    if error != nil {
                        print("**ERROR**\(error!)")
                    } else {
                        print("Created user successfully")
                        self.performSegue(withIdentifier: "signInSegue", sender: nil)

                    }
                })
            } else {
                print("Sign in successful")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
        }
        
    }
    
}

