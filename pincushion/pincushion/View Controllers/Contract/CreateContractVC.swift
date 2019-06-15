//
//  CreateContractVC.swift
//  pincushion
//
//  Created by Matt Green on 5/17/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class CreateContractVC: UIViewController {
    // MARK:- IBOutlets
    @IBOutlet weak var datePickerOutlet: UIDatePicker!
    @IBOutlet weak var bustField: UITextField!
    @IBOutlet weak var waistField: UITextField!
    @IBOutlet weak var hipField: UITextField!
    @IBOutlet weak var brideNameField: UITextField!
    @IBOutlet weak var specialistNameLabel: UILabel!
    
    //outlets for applying theme
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var brideNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var bustLabel: UILabel!
    @IBOutlet weak var waistLabel: UILabel!
    @IBOutlet weak var hipLabel: UILabel!
    @IBOutlet weak var reviewContractButton: UIButton!
    @IBOutlet weak var createContractButton: UIButton!
    
    // MARK:- Properties
    let db = AppDelegate.shared.fsDB
    var authHandle:AuthStateDidChangeListenerHandle!
    var currentUserUID:String = ""
    var currentUserDisplayName:String = ""
    var selectedDate:Date = Date.init() // event date
    var purchaseDate:Date = Date.init() // dress purchase date
    var contractUID: String = ""
    var dressUID: String = ""
    
    var theDateNeeded: Date = Date.init()
    
    // MARK:- View Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
          self.navigationController?.setToolbarHidden(false, animated: true)
       
        // MARK: - Firebase state change handler
        authHandle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                // get current user UID
                self.currentUserUID = user!.uid
                self.currentUserDisplayName = user!.displayName ?? "Specialist: "
                SpecialistSingleton.displayName = user!.displayName ?? "Specialist: "
                SpecialistSingleton.uid = user!.uid
                self.specialistNameLabel.text = SpecialistSingleton.displayName
            }
        }
        //getAllBrides()
        self.title = "Create Contract"
   
        theDateNeeded = self.datePickerOutlet.date
    
        specialistNameLabel.text = SpecialistSingleton.displayName
        //apply theme to view
        view.backgroundColor = Theme.current.batiste
        backgroundColorView.backgroundColor = Theme.current.lydian_40
       // specialistNameField.backgroundColor = Theme.current.batiste
        brideNameField.backgroundColor = Theme.current.batiste
        brideNameField.attributedPlaceholder = NSAttributedString(
            string: "Enter name...",
            attributes: [NSAttributedString.Key.foregroundColor: Theme.current.arrus_20])
    
        bustField.backgroundColor = Theme.current.batiste
        bustField.attributedPlaceholder = NSAttributedString(
            string: "Type measurement...",
            attributes: [NSAttributedString.Key.foregroundColor: Theme.current.arrus_20])
     
        waistField.backgroundColor = Theme.current.batiste
        waistField.attributedPlaceholder = NSAttributedString(
            string: "Type measurement...",
            attributes: [NSAttributedString.Key.foregroundColor: Theme.current.arrus_20])
        
        hipField.backgroundColor = Theme.current.batiste
        hipField.attributedPlaceholder = NSAttributedString(
            string: "Type measurement...",
            attributes: [NSAttributedString.Key.foregroundColor: Theme.current.arrus_20])
        
        reviewContractButton.setTitleColor(Theme.current.essence, for: .normal)
        createContractButton.setTitleColor(Theme.current.essence, for: .normal)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        Auth.auth().removeStateDidChangeListener(authHandle!)
    }

    // Nick's methods for TPPDF
    func getSpecialist() -> String {
       // return self.specialistNameField?.text ?? "No specialist entered"
        return SpecialistSingleton.displayName ?? "No specialist entered"
    }
    
    func getEventDate() -> Date {
        return ContractSingleton.current.eventDate
    }
    
    func getPurchaseDate() -> Date{
        return purchaseDate
    }
    
    func getBust() -> String{
        return String(MeasurementSingleton.current.0)
    }
    func getWaist() -> String{
        return String(MeasurementSingleton.current.1)
    }
    func getHip() -> String{
        return String(MeasurementSingleton.current.2)
    }

}

    //MARK:- IBActions
extension CreateContractVC {
    @IBAction func datePickerAction(_ sender: Any) {
        self.selectedDate = self.datePickerOutlet.date
        theDateNeeded = self.datePickerOutlet.date
    }
   
    @IBAction func signOutAction(_ sender: UIBarButtonItem) {
        //print("Sign Out pressed")
        
        // firebase sign out
        // https://firebase.google.com/docs/auth/ios/password-auth?authuser=0
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            Auth.auth().removeStateDidChangeListener(authHandle!)
            authHandle = Auth.auth().addStateDidChangeListener { (auth, user) in
                if user != nil {
                    // get current user UID
                    self.currentUserUID = user!.uid
                    self.currentUserDisplayName = user!.displayName ?? "Specialist: "
                    SpecialistSingleton.displayName = user!.displayName ?? "Specialist: "
                    SpecialistSingleton.uid = user!.uid
                    //self.specialistNameOutlet.text = self.currentUserDisplayName
                } else {
                    // move to login VC
                    // print("should move to loginVC")
                    // verify sign out with alert
                    let verifyAlert = createCustomAlert(
                        title: "Ready to Sign Out?",
                        message: "All progress will be lost",
                        confirmTitle: "Sign Out",
                        cancelTitle: "Cancel",
                        confirmHandler: {
                            // reset all signletons
                            ContractSingleton.current = ContractSingleton.originalValues
                            MeasurementSingleton.current = (0,0,0)
                            SpecialistSingleton.uid = ""
                            SpecialistSingleton.displayName = ""
                            BrideSingleton.uid = ""
                            BrideSingleton.fullName = ""
                            
                            // clear all fields
                            self.brideNameField?.text = ""
                            self.bustField?.text = ""
                            self.waistField?.text = ""
                            self.hipField?.text = ""
                            
                            // pop view
                            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                            let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC")
                            self.present(vc, animated: false, completion: nil)
                    })
                    self.present(verifyAlert, animated: true, completion: nil)
                }
            }
            //print("attempting to sign out...")
            
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
    }
    
    @IBAction func createContractAction(_ sender: Any) {
        // check if measurements are empty
        if getMeasurements() == (0,0,0) {
            let okayController: UIAlertController = createAlert(title: "Please enter measurements", message: "Whole and decimals numbers only", handler: {})
            self.present(okayController, animated: true, completion: nil)
            //print("ContractUID: \(ContractSingleton.current.uid)")
        }
        
        // you already have a contract
        if ContractSingleton.current.uid != "" {
            let contractAlert = createCustomAlert(
                title: "Erase your current contract?",
                message: "Current contract information will be erased. This cannot be undone.",
                confirmTitle: "Start New",
                cancelTitle: "Cancel",
                confirmHandler: {
                    let alertController = UIAlertController(
                        title: "Ready to Create Contract?",
                        message: "Tap cancel to verify information first",
                        preferredStyle: UIAlertController.Style.alert)
                    
                    let cancelAction = UIAlertAction(
                        title: "Cancel",
                        style: .destructive) {
                            (action) -> Void in
                            //handler()
                            //print("pressed cancel")
                    }
                    
                    let confirmAction = UIAlertAction(
                        title: "Create",
                        style: .default) {
                            (action) -> Void in
                            
                            // get info from view
                            // make firebase contract (which makes firebase dress)
                            self.dressUID = self.makeDress()
                            self.contractUID = self.makeContract(dressUID: self.dressUID)
                            
                            // reset singleton when creating new contract
                            ContractSingleton.current = ContractSingleton.originalValues
                            self.updateContractSingleton()
                            //print(ContractSingleton.current)
                            
                            // make sure we've got a bride name typed in
                            if let bName = self.brideNameField.text {
                                // print("you don't have a bride name")
                                //self.brideName = bName
                                BrideSingleton.fullName = bName
                            }
                            
                            // add bride to firebase
                            let bridesRef = self.db!.child("brides")
                            let brideUID = addBrideToFBDB(
                                db: bridesRef,
                                specialistUID: self.currentUserUID,
                                firstName: BrideSingleton.fullName,
                                lastName: BrideSingleton.fullName,
                                email: "test@dot.com",
                                measurements: ["-1"]
                            )
                            
                            // get measurement
                            MeasurementSingleton.current = self.getMeasurements()
                            
                            
                            // add measurement to firebase
                            let measurementsRef = self.db!.child("measurements")
                            addMeasurementToFBDB(
                                db: measurementsRef,
                                brideUID: brideUID,
                                date: Date(),
                                bust: MeasurementSingleton.current.0,
                                waist: MeasurementSingleton.current.1,
                                hip: MeasurementSingleton.current.2
                            )
                            
                            
                            
                            // jump to next view when we've made a contract
                            self.performSegue(withIdentifier: "SelectAlterations", sender: self)
                    }
                    
                    alertController.addAction(cancelAction)
                    alertController.addAction(confirmAction)
                    
                    alertController.view.tintColor = UIColor.init(named: "Bazooka")
                    
                    self.present(alertController, animated: true, completion: nil)
            })
            
            contractAlert.view.tintColor = UIColor.init(named: "Bazooka")
            self.present(contractAlert, animated: true, completion: nil)
        }
        
        // everything is good... go for it!
        else {
        let alertController = UIAlertController(
            title: "Ready to Create Contract?",
            message: "Tap cancel to verify information first",
            preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .destructive) {
                (action) -> Void in
                //handler()
                //print("pressed cancel")
        }
        
        let confirmAction = UIAlertAction(
            title: "Create",
            style: .default) {
                (action) -> Void in

                // get info from view
                // make firebase contract (which makes firebase dress)
                self.dressUID = self.makeDress()
                self.contractUID = self.makeContract(dressUID: self.dressUID)
                
                // reset singleton when creating new contract
                ContractSingleton.current = ContractSingleton.originalValues
                self.updateContractSingleton()
               // print(ContractSingleton.current)
                
//                if let sName = self.specialistNameField.text {
//                    SpecialistSingleton.displayName = sName
//                }
                
                // make sure we've got a bride name typed in
                if let bName = self.brideNameField.text {
                   // print("you don't have a bride name")
                    //self.brideName = bName
                    BrideSingleton.fullName = bName
                }
                
                // add bride to firebase
                let bridesRef = self.db!.child("brides")
                let brideUID = addBrideToFBDB(
                    db: bridesRef,
                    specialistUID: self.currentUserUID,
                    firstName: BrideSingleton.fullName,
                    lastName: BrideSingleton.fullName,
                    email: "test@dot.com",
                    measurements: ["-1"]
                )
                
                // get measurement
                MeasurementSingleton.current = self.getMeasurements()
                
                // add measurement to firebase
                let measurementsRef = self.db!.child("measurements")
                addMeasurementToFBDB(
                    db: measurementsRef,
                    brideUID: brideUID,
                    date: Date(),
                    bust: MeasurementSingleton.current.0,
                    waist: MeasurementSingleton.current.1,
                    hip: MeasurementSingleton.current.2
                )

                // jump to next view when we've made a contract
                self.performSegue(withIdentifier: "SelectAlterations", sender: self)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        alertController.view.tintColor = UIColor.init(named: "Bazooka")
        self.present(alertController, animated: true, completion: nil)
    }
    }
 
}

// MARK:- Segue
extension CreateContractVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        
        case "SelectAlterations"?:
            //print("you tapped: Next: Select Alteration(s)\n")
            print("your contractUID: \(ContractSingleton.current.uid)")
        case "ShowReviewContractVC"?:
            print("You selected: ReviewContractVC")
           
        default:
            preconditionFailure("Unexpected seque identifier")
        }
    }
}

//MARK:- Helper functions
extension CreateContractVC {
    
    fileprivate func updateContractSingleton() {
        ContractSingleton.current.specialistUID = self.currentUserUID
        ContractSingleton.current.eventDate = self.selectedDate
        ContractSingleton.current.brideUID = BrideSingleton.uid 
        ContractSingleton.current.specialistUID = self.currentUserUID
        ContractSingleton.current.dressUID = self.dressUID
        ContractSingleton.current.uid = self.contractUID
    }
    
    fileprivate func getMeasurements() -> (Float,Float,Float) {
        let bust = bustField.text!
        let waist = waistField.text!
        let hip = hipField.text!
        
        if let bustF = Float(bust), let waistF = Float(waist), let hipF = Float(hip) {
            return (bustF, waistF, hipF)
        } else {
            //return (Float(bustField.placeholder!)!, Float(waistField.placeholder!)!, Float(hipField.placeholder!)!)
            return (0,0,0)
        }
    }
  
    // make a firebase contract
    fileprivate func makeContract(dressUID: String ) -> String {
        let contractsRef = db!.child("contracts")
        return addContractToFBDB(
            db: contractsRef,
            dressUID: dressUID,
            brideUID: BrideSingleton.uid,
            specialistUID: self.currentUserUID,
            eventDate: self.selectedDate)
    }
    
    // make firebase dress obejct
    fileprivate func makeDress() -> String {
        let dressesRef = db!.child("dresses")
        let dressUID = addDressToFBDB(
            db: dressesRef,
            invoiceNumber: 0001,
            brideUID: BrideSingleton.uid,
            purchaseDate: self.purchaseDate)
        return dressUID
    }
    
    // MARK:- View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        // set textFieldDelegates
        bustField.delegate = self
        waistField.delegate = self
        hipField.delegate = self
        
        // clear button mode
        bustField.clearButtonMode = .whileEditing
        hipField.clearButtonMode = .whileEditing
        waistField.clearButtonMode = .whileEditing
        brideNameField.clearButtonMode = .whileEditing
    }
}

extension CreateContractVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var charSet = CharacterSet.letters
        charSet.insert(charactersIn: "-`")
        return string.rangeOfCharacter(from: charSet) == nil
    }
}




