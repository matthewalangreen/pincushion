//
//  CreateAccountVC.swift
//  pincushion
//
//  Created by Matt Green on 5/1/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class CreateAccountVC: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var confirmEmailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    //outlets to apply theme to view
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var dividerOne: UIView!
    @IBOutlet weak var dividerTwo: UIView!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var returnToLoginButton: UIButton!
    
    // MARK: - IBActions
    @IBAction func goBackAction(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    //TODO: create specialist field in db when account created
    @IBAction func createAccountAction(_ sender: Any) {
        let emailMatch:Bool = emailField?.text == confirmEmailField?.text
        let passMatch:Bool = passwordField?.text == confirmPasswordField?.text
        let hasFirstName:Bool = firstNameField?.text != nil
        let hasLastName:Bool = lastNameField?.text != nil
        
        if emailMatch && passMatch && hasFirstName && hasLastName {
            let user = emailField.text!
            let pass = passwordField.text!
            Auth.auth().createUser(withEmail: user, password: pass) { authResult, error in
                // Everything worked great!
                if error == nil && authResult != nil {
                    // Auth success
                   
                    // MARK: - Firebase: set displayName
                    //  with firstname and lastname
                    let f = self.firstNameField.text!
                    let l = self.lastNameField.text!
                    
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = f + " " + l
                    changeRequest?.commitChanges { (error) in
                        // ...
                    }
                    
                    // Show alert to welcome user
                    let alert: UIAlertController = createAlert(title: "Welcome to Pincusion!", message: "\(self.firstNameField.text!)", handler: {
                        
                        // create specialist object in firebase db
                        let fsDB = AppDelegate.shared.fsDB
                        let specialistsRef = fsDB!.child("specialists")
                        let uid = authResult!.user.uid
                        
                        // update singleton
                        SpecialistSingleton.uid = uid
                        
                        //TODO fix brides string implementation --> Replace with Struct that is Codable
                        let brides:[String] = ["-1"]
                        
                        addSpecialistToFBDB(db: specialistsRef, uid: uid, firstName: self.firstNameField.text!, lastName: self.lastNameField.text!, email: self.emailField.text!, brides: brides)
                        
                        // show SpecialistNavVC by dismissing this view and the view that presented it
                        self.presentingViewController?.dismiss(animated: false, completion: nil)
                    })
                    self.present(alert, animated: true, completion: nil)
                } else {  // Firebase Auth Error
                    if error != nil {
                        self.handleFirebaseAuthError(error!)
                        // clear fields
                        let errorCode = AuthErrorCode(rawValue: error!._code)
                        if errorCode?.errorMessage == "The email is already in use with another account" {
                            self.resetEmail()
                        }
                        if errorCode?.errorMessage == "Your password is too weak. The password must be 6 characters long or more." {
                           self.resetPassword()
                        }
                    }
                }
            }
        } else {  // passwords or emails didn't match
            if !passMatch {
                let alert: UIAlertController = createAlert(title: "Oops!", message: "Your passwords don't match", handler: {})
                self.present(alert, animated: true, completion: nil)
                resetPassword()
            } else {
                let alert: UIAlertController = createAlert(title: "Oops!", message: "Your email addresses don't match", handler: {})
                self.present(alert, animated: true, completion: nil)
                resetEmail()
            }
        }
    }

    // MARK: - helpers
    fileprivate func resetEmail() {
        self.emailField.text = ""
        self.confirmEmailField.text = ""
    }
    
    fileprivate func resetPassword() {
        self.passwordField.text = ""
        self.confirmPasswordField.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameField.clearButtonMode = .whileEditing
        lastNameField.clearButtonMode = .whileEditing
        emailField.clearButtonMode = .whileEditing
        confirmEmailField.clearButtonMode = .whileEditing
        passwordField.clearButtonMode = .whileEditing
        confirmPasswordField.clearButtonMode = .whileEditing

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        //apply theme to CreateAccountVC
        view.backgroundColor = Theme.current.batiste
        backgroundColorView.backgroundColor = Theme.current.lydian_40
        dividerOne.backgroundColor = Theme.current.bazooka_20
        dividerTwo.backgroundColor = Theme.current.bazooka_20
        createAccountButton.setTitleColor(Theme.current.essence, for: .normal)
        returnToLoginButton.tintColor = Theme.current.arrus
        
        firstNameField.backgroundColor = Theme.current.batiste
        lastNameField.backgroundColor = Theme.current.batiste
        emailField.backgroundColor = Theme.current.batiste
        confirmEmailField.backgroundColor = Theme.current.batiste
        passwordField.backgroundColor = Theme.current.batiste
        confirmPasswordField.backgroundColor = Theme.current.batiste
        
        firstNameField.attributedPlaceholder = NSAttributedString(
            string: "First Name",
            attributes: [NSAttributedString.Key.foregroundColor: Theme.current.arrus_20])
        
        lastNameField.attributedPlaceholder = NSAttributedString(
            string: "Last Name",
            attributes: [NSAttributedString.Key.foregroundColor: Theme.current.arrus_20])
        
        emailField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: Theme.current.arrus_20])
        
        confirmEmailField.attributedPlaceholder = NSAttributedString(
            string: "Confirm Email",
            attributes: [NSAttributedString.Key.foregroundColor: Theme.current.arrus_20])
        
        passwordField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: Theme.current.arrus_20])
        
        confirmPasswordField.attributedPlaceholder = NSAttributedString(
            string: "Confirm Password",
            attributes: [NSAttributedString.Key.foregroundColor: Theme.current.arrus_20])
    }
}


