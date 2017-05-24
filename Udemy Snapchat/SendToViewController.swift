//
//  SendToViewController.swift
//  Udemy Snapchat
//
//  Created by Will Laco on 5/22/17.
//  Copyright © 2017 Will Laco. All rights reserved.
//

import UIKit
import Firebase

class SendToViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var users : [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        Database.database().reference().child("users").observe(DataEventType.childAdded, with: {(DataSnapshot) in
            print(DataSnapshot)
            
            let user = User()
            user.email = (DataSnapshot.value! as! [String:AnyObject])["email"] as! String
            user.uid = DataSnapshot.key
            
            self.users.append(user)

            self.tableView.reloadData()
        })

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.email
        
        return cell
    }
   
}
