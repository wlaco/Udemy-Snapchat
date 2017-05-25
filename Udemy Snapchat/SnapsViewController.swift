//
//  SnapsViewController.swift
//  Udemy Snapchat
//
//  Created by Will Laco on 5/19/17.
//  Copyright © 2017 Will Laco. All rights reserved.
//

import UIKit
import Firebase

class SnapsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var snaps : [Snap] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childAdded, with: {(DataSnapshot) in
            print(DataSnapshot)
            
            let snap = Snap()
            snap.imageURL = (DataSnapshot.value! as! [String:AnyObject])["imageURL"] as! String
            snap.desc = (DataSnapshot.value! as! [String:AnyObject])["description"] as! String
            snap.from = (DataSnapshot.value! as! [String:AnyObject])["from"] as! String
            snap.uuid = (DataSnapshot.value! as! [String:AnyObject])["uuid"] as! String

            snap.key = DataSnapshot.key
            
            self.snaps.append(snap)
            
            self.tableView.reloadData()
        })
        
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childRemoved, with: {(DataSnapshot) in
            print(DataSnapshot)
            
            
            var index = 0
            for snap in self.snaps {
                if snap.key == DataSnapshot.key {
                    self.snaps.remove(at: index)
                }
                index += 1
            }
            
            self.tableView.reloadData()
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if snaps.count == 0 {
            return 1
        } else {
        return snaps.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        if snaps.count == 0 {
            cell.textLabel?.text = "You have no snaps"
            
        } else {
            
        let snap = snaps[indexPath.row]
        
        cell.textLabel?.text = snap.from
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let snap = snaps[indexPath.row]
        
        performSegue(withIdentifier: "viewSnapSegue", sender: snap)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "viewSnapSegue" {
        let nextVC = segue.destination as! ViewSnapViewController
        nextVC.snap = sender as! Snap
        }
    }
    

    @IBAction func logOutTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    


}
