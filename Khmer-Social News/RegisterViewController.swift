//
//  RegisterViewController.swift
//  AniSwagChat
//
//  Created by ភី ម៉ារ៉ាសុី on 7/9/16.
//  Copyright © 2016 ភី ម៉ារ៉ាសុី. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
class RegisterViewController: UITableViewController, UITextFieldDelegate{

    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var passWord: UITextField!
    
    @IBOutlet weak var rePass: UITextField!
    
    
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var btnRegister: UIButton!
    

   // var ref = FIRDatabaseReference()
    
    override func viewDidLoad() {
     //   ref = FIRDatabase.database().reference()
        super.viewDidLoad()
        
        userName.delegate = self
        passWord.delegate = self
        rePass.delegate = self
        userName.becomeFirstResponder()
        PropertyControl.propertyControl.setButton([btnCancel,btnRegister])
        PropertyControl.propertyControl.setTextFeild(userName,passWord,rePass)
        let tap = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.dimisskey))
        
        self.view.addGestureRecognizer(tap)

        
    }
    func dimisskey(){
        userName.resignFirstResponder()
        passWord.resignFirstResponder()
        rePass.resignFirstResponder()
    }
    @IBAction func btnClicked(_ sender: UIButton){
        
        let buttonName = sender.titleLabel?.text
        if(buttonName == "Register"){
        //DataService.dataService.ref.
            if(passWord.text! == rePass.text!){
            FIRAuth.auth()?.createUser(withEmail: userName.text!, password: passWord.text!, completion: { error, result in
                print("xD")
                FIRAuth.auth()?.currentUser?.sendEmailVerification(completion: {
                    (e) in
                    
                    if  e != nil {
                        print(error.debugDescription)
                    }else{
                        print("xD")
                    
                    }
                })
            })
                
                
            }
            else{
                
            }
            
            
            
            
        }else if ( buttonName == "Cancel"){
            NotificationCenter.default.post(
                Notification(name: Notification.Name(rawValue: "popUpDidClose"), object: self)
            )
            self.dismiss(animated: true, completion: nil)
        }
        
        
        
        
    }
    
    
       
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        if(textField == userName){
            textField.resignFirstResponder()
            passWord.becomeFirstResponder()
        }else if (textField == passWord){
            textField.resignFirstResponder()
            rePass.becomeFirstResponder()
        }else{
            
        
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if(textField == userName){

            
            
            textField.returnKeyType = UIReturnKeyType.next
        }
        else if(textField == passWord){
                textField.returnKeyType = UIReturnKeyType.next
        }
        else {
            textField.returnKeyType = UIReturnKeyType.go
        }
        
    }
    
    
    
    
    
    
    
    
}
