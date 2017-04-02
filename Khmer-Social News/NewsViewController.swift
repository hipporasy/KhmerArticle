//
//  NewsViewController.swift
//  Khmer-Social News
//
//  Created by ភី ម៉ារ៉ាសុី on 8/3/16.
//  Copyright © 2016 ភី ម៉ារ៉ាសុី. All rights reserved.
//

import UIKit
import Firebase

class NewsViewController: UIViewController{
    var newsId = NSString()
    var userName = NSString()
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.backgroundColor = UIColor.clear
        textView.layer.borderWidth = 2
        textView.layer.backgroundColor = UIColor.gray.cgColor
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.font = UIFont(name: "Avenir-Light", size: 16)
              view.addSubview(textView)
        
        
        navigationItem.title = "Article"
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        var ref = FIRDatabaseReference()
        ref = FIRDatabase.database().reference()
        ref.child("News").child(newsId as String).observe(.value) { (snap:FIRDataSnapshot) in
            
            let snapshot = snap.value as? NSDictionary
            if let text = snapshot?["Info"] as? String{
                if let title = snapshot?["Name"] as? String{
                    
                    
                    //  self.navigationItem.title = title
                
                self.textView.text = "\t The Article: \(title) \n\t\(text)"
                }
            }
            
        }
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
}
