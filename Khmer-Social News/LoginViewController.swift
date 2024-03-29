//
//  LoginViewController.swift
//  AniSwagChat
//
//  Created by ភី ម៉ារ៉ាសុី on 7/1/16.
//  Copyright © 2016 ភី ម៉ារ៉ាសុី. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UITableViewController,UITextFieldDelegate {

    var uid = String();
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.delegate = self
        passWord.delegate = self
        
        PropertyControl.propertyControl.setTextFeild(userName,passWord)
        PropertyControl.propertyControl.setButton([btnCancel,btnLogin])
        userName.becomeFirstResponder()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dimisskey))

        self.view.addGestureRecognizer(tap)


    }
    func dimisskey(){
        
        self.userName.resignFirstResponder()
        self.passWord.resignFirstResponder()
        
    }
    @IBAction func btnClick(_ senderId: UIButton){
        
        let buttonName = (senderId.titleLabel?.text)! as String
        if(buttonName == "Login"){
            
            makeLogin()
        }
        else {
          
            //  ViewController.view
            NotificationCenter.default.post(
                Notification(name: Notification.Name(rawValue: "popUpDidClose"), object: self)
            )
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func makeLogin(){
        
        //self.dismissViewControllerAnimated(true, completion: nil)
        
        if userName.text! == "a" && passWord.text! == "a" {
            userName.text = "aa@gmail.com"
            passWord.text = "123456"
        
        }
        
        FIRAuth.auth()?.signIn(withEmail: userName.text!, password: passWord.text!, completion: {
            (result, error) in
            if(error != nil){
                
                let alert = AlertService.alertService.errorAlert("Oops! Sorry", message: "Your email or password is not correct")
                self.present(alert, animated: true, completion: nil)
                
                
                print(error)
        
            }else{
            
                UserDefaults.standard.setValue(result?.uid, forKey: "uid")
                self.uid = (result?.uid)!
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
            
        })

        
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if( textField == userName){
            textField.returnKeyType = UIReturnKeyType.next
        }else{
            textField.returnKeyType = UIReturnKeyType.go
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if( textField == userName){
            textField.resignFirstResponder()
            passWord.becomeFirstResponder()
        }
        else if(textField == passWord){
            
            makeLogin()
            
        }
        return true
    }
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "loginSegue"){
            let tabBar = segue.destination as! UITabBarController
            let navi = tabBar.viewControllers![0] as! UINavigationController
            let destination = navi.topViewController as! HomeTableViewController
            let navi2 = tabBar.viewControllers![2] as! UINavigationController
            let destination2 = navi2.topViewController as! ProfileViewController
            destination2.uid = uid as NSString
            destination.uid = uid
            
        }
    }
    
    
    
    
    
}
