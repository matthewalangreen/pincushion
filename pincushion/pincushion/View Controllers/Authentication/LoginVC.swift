//
//  LoginVC.swift
//  pincushion
//
//  Created by Matt Green on 5/1/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    var authHandle: AuthStateDidChangeListenerHandle!
    
    var currentUserUID:String = ""
    
    // MARK: - IBOutlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logoutButtonText: UIButton!
    @IBOutlet weak var loginButtonLabel: UIButton!
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var createAccountButtonLabel: UIButton!
    
    //MARK: - IBActions
    @IBAction func createAccountAction(_ sender: Any) {
    }
    
    //MARK: - Actions
    @IBAction func loginAction(_ sender: UIButton) {
        let user = usernameTextField.text!
        let pass = passwordTextField.text!
        
        Auth.auth().signIn(withEmail: user, password: pass) { [weak self] user, error in
           // guard let strongSelf = self else { print("error: \(error?.localizedDescription ?? "OOPS")"); return }
            guard let _ = self else { print("error: \(error?.localizedDescription ?? "OOPS")"); return }
            
            
            // auth success
            //if let currentUser = user?.user {
            if let _ = user?.user {
                //let rootViewController = AppDelegate.shared.rootViewController
                //rootViewController.
                self?.dismiss(animated: false, completion: nil)
            } else { // auth failure
                let alert = createAlert(title: "Oops!", message: "Nope. Try again.", handler: {/* empty */})
                self?.present(alert, animated: true, completion: nil)
            }
        }
    }

    // MARK: - Overrides
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)

        authHandle = Auth.auth().addStateDidChangeListener { (auth, user) in
            // ...
            //print("LoginVC User: \(user?.uid ?? "DEFAULT")")
            
            if user != nil {
               let rootVC = AppDelegate.shared.rootViewController
                rootVC.currentUserUID = user!.uid
                SpecialistSingleton.uid = user!.uid // change to new value
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        // Apply theme colors
        loginButtonLabel.tintColor = Theme.current.essence
        backgroundColorView.backgroundColor = Theme.current.lydian_40
        createAccountButtonLabel.tintColor = Theme.current.arrus
        view.backgroundColor = Theme.current.batiste
        
        usernameTextField.backgroundColor = Theme.current.batiste
        passwordTextField.backgroundColor = Theme.current.batiste
        
        usernameTextField.attributedPlaceholder = NSAttributedString(
            string: "Email address",
            attributes: [NSAttributedString.Key.foregroundColor: Theme.current.arrus_20])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: Theme.current.arrus_20])

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        Auth.auth().removeStateDidChangeListener(authHandle!)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showCreateAccountVC"?:
            //TODO: Implement logic here & remove Print
            print("You switched to CreateAccountVC")
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    // MARK: - Hide heyboard
    // TODO: Fix on iPad device.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        passwordTextField.clearButtonMode = .whileEditing
        usernameTextField.clearButtonMode = .whileEditing
    }
}


