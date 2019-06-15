//
//  AddBrideVC.swift
//  pincushion
//
//  Created by Matt Green on 5/3/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class AddBrideVC: UIViewController {
    var authHandle:AuthStateDidChangeListenerHandle!
    var currentUserUID:String = ""
    
    // get fsDB refernce from app Delegate
    var fsDB = AppDelegate.shared.fsDB
    
    // MARK:- IBoutlets
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    //TODO: Figure out where to place the coreDataStack object... not in AppDelegate
    
    // MARK: - IBActions
    @IBAction func addBrideAction(_ sender: Any) {
        //Show alert to confirm
        var brideName:String = ""
        var fName:String = ""
        var lName:String = ""
        var email:String = ""
        
        if emailField.text != nil {
            email = emailField.text!
        }
        
        if firstNameField.text != nil && lastNameField.text != nil {
            fName = firstNameField.text!
            lName = lastNameField.text!
            
            brideName = "\(fName) \(lName)"
        }

        let alert = addBrideAlert(title: "Confirm add bride named:", message: brideName, handler: {
            
            self.navigationController?.popViewController(animated: true)
           
        })
        self.present(alert, animated: true, completion: {
            // get db refs
            let bridesRef = self.fsDB!.child("brides")
            let specialistsRef = self.fsDB!.child("specialists")
           
            // make Bride object & add to Firebase
            let bride = addBrideToFBDB(
                db: bridesRef,
                specialistUID: self.currentUserUID,
                firstName: fName,
                lastName: lName,
                email: email,
                measurements: ["-1"]
            )
            
            // add brides to array
            let brides:[String] = [bride]
            
            getBridesForSpecialist(uid: self.currentUserUID, db: specialistsRef, newBrides: brides)
        })
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         self.title = "Add New Bride"
        
        // MARK: - Firebase state change handler
        authHandle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                // get current user UID
                self.currentUserUID = user!.uid
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        Auth.auth().removeStateDidChangeListener(authHandle!)
    }
  
}
