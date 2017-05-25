//
//  ViewSnapViewController.swift
//  Udemy Snapchat
//
//  Created by Will Laco on 5/24/17.
//  Copyright © 2017 Will Laco. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class ViewSnapViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var fromLabel: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.sd_setImage(with: URL(string: snap.imageURL))
        fromLabel.text? = snap.from
        descLabel.text? = snap.desc

    }
    
    

}
