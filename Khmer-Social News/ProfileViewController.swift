//
//  ProfileViewController.swift
//  Khmer-Social News
//
//  Created by ភី ម៉ារ៉ាសុី on 8/11/16.
//  Copyright © 2016 ភី ម៉ារ៉ាសុី. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UITableViewController {
   
    var uid = NSString()
    var ref = FIRDatabaseReference()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var Job: UILabel!
    @IBOutlet weak var dateBirth: UILabel!
    @IBOutlet weak var nickName: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        textView.layer.borderWidth = 3
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.masksToBounds = true
        textView.backgroundColor = UIColor.clear
        
        
        
        
         }
    override func viewWillAppear(_ animated: Bool) {
        ref.child("User").child(uid as String).observe(.value) { (snap:FIRDataSnapshot) in
            let snapshot = snap.value as? NSDictionary
            if let name = snapshot?["Name"] as? String{
             self.navigationItem.title = name
            }
            if let nick = snapshot?["Nickname"] as? String{
                self.nickName.text = nick
            }
            if let image = snapshot?["Image"] as? String{
                if image == "xd"{
                }
            }
            if let dob = snapshot?["DoB"] as? String{
                self.dateBirth.text = dob
                
            }
            if let info = snapshot?["Info"] as? String{
                self.textView.text = info
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
