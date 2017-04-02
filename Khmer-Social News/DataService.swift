//
//  DataService.swift
//  Khmer-Social News
//
//  Created by ភី ម៉ារ៉ាសុី on 7/29/16.
//  Copyright © 2016 ភី ម៉ារ៉ាសុី. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
class DataService{
    
    
    static let dataService = DataService()
    fileprivate var _ref: FIRDatabaseReference = FIRDatabase.database().reference()
    fileprivate var _userRef: FIRDatabaseReference = FIRDatabase.database().reference().child("User")
    fileprivate var _newsRef: FIRDatabaseReference = FIRDatabase.database().reference().child("News")
  //  private var _authRef = FIRAuth()
    
    var ref: FIRDatabaseReference{
        return _ref
    }
    var userRef: FIRDatabaseReference{
        return _userRef
    }
    var newsRef: FIRDatabaseReference{
        return _newsRef
    }
    
    var current_userRef: FIRDatabaseReference{
        let userID = UserDefaults.standard.value(forKey: "uid") as! String
        
        let currentUser = _userRef.child(userID)
        
        return currentUser
        
    }
    
    
    
    
    
}
