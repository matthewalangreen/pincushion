//
//  AddAlterationVC.swift
//  pincushion
//
//  Created by Matt Green on 5/17/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class AddAlterationVC: UIViewController {

    //MARK:- Properties
    let db = AppDelegate.shared.fsDB
    var object: AlterationType! // AlterationType object reference passed in
    var alterationUID: String = "3.14" // will be set once we get to firebase
    var costWasCalculated: Bool = false
    
    // current AlterationStruct. Will be stored to firebase
    var myAlterationStruct : AlterationStruct! // set in viewDidLoad

    //MARK:- IBOutlets
    @IBOutlet weak var alterationDescriptionLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var costUnitLabel: UILabel!
    @IBOutlet weak var additionalCostField: UITextField!
    @IBOutlet weak var additionalCostDetailsLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var priceRangeLabel: UILabel!
    @IBOutlet weak var priceRangeDescriptionLabel: UILabel!
    @IBOutlet weak var actualPriceField: UITextField!
    
    //MARK:- IBActions
    @IBAction func addToContractAction(_ sender: Any) {
        // if totalcost hasn't been updated
        if self.costWasCalculated == false {
            let okayAlert: UIAlertController = createAlert(title: "Press: Calculate cost first", message: "Thank you", handler: {})
            self.present(okayAlert, animated: true, completion: nil)
        }
        // update
        else {
       
        
        let alert: UIAlertController = createCustomAlert(title: "Add alteration to contract?", message: "Tap cancel to verify information", confirmTitle: "Add", cancelTitle: "Cancel", confirmHandler: {
            self.navigationController?.popViewController(animated: true)
            
            var currentAlterations = ContractSingleton.current.alterations
            currentAlterations.append(self.alterationUID)
            ContractSingleton.current.alterations = currentAlterations
            
            // add alteration to contract in fbdb
            // get alterationUID
            self.alterationUID = self.makeAlteration(contractUID: ContractSingleton.current.uid, alterationStruct: self.myAlterationStruct)
            
            ContractSingleton.current.alterations.append(self.alterationUID)
            
            updateAlterationsForContract(db: self.db, contractUID: ContractSingleton.current.uid, newAlterationUID: self.alterationUID)
            
            })
        
         self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func updateTotalAction(_ sender: Any) {
        self.costWasCalculated = true
        // get new values and save them to myAlterationStruct
        myAlterationStruct.actualCost = Float(self.actualPriceField!.text!) ?? 3.14
        myAlterationStruct.units = Int(self.quantityField!.text!) ?? 314
        myAlterationStruct.secondaryCost = Float(self.additionalCostField!.text!) ?? 3.14
        
        // use a method to get total cost and then store it back into the struct
        myAlterationStruct.totalCost = myAlterationStruct.getTotalCost()
        
        // show updated value of .totalCost calculated property
        self.totalCostLabel?.text = String(myAlterationStruct.totalCost) + "0"
    }
    
    
    //MARK:- Helper functions
    fileprivate func makeAlteration(contractUID: String, alterationStruct: AlterationStruct) -> String {
        let ref = db!.child("alterations")
        return addAlterationToFBDB(
            db: ref,
            contractUID: contractUID,
            alterationStruct: alterationStruct)
    }
    
    fileprivate func populateFields() {
       
        // change formatting of labels based on if a price range exists (if) or not (else)
        var priceRangeString = ""
        
        if priceRangeExists() {
            self.priceRangeDescriptionLabel.text = "Price range:"
            priceRangeString = "$" + String(format: "%.0f", self.myAlterationStruct.minCost) + " - $" + String(format: "%.0f", self.myAlterationStruct.maxCost)

        } else {
            self.priceRangeDescriptionLabel.text = "Typical price:"
            priceRangeString = "$" + String(format: "%.0f", self.myAlterationStruct.minCost)
        }

        self.alterationDescriptionLabel?.text = object.name
        self.priceRangeLabel?.text = priceRangeString
        self.actualPriceField?.text = String(format: "%.0f", self.myAlterationStruct.actualCost)
        self.detailsLabel?.text = self.myAlterationStruct.costDetails
        self.quantityField?.text = String(self.myAlterationStruct.units)
        self.costUnitLabel?.text = self.myAlterationStruct.costUnit
        self.additionalCostField?.text = String(format: "%.0f", self.myAlterationStruct.secondaryCost)
        self.additionalCostDetailsLabel?.text = self.myAlterationStruct.secondaryCostDetails
        self.totalCostLabel?.text = String(format: "%.0f", self.myAlterationStruct.totalCost)
    }
    
    // check if we need to show price range as range
    fileprivate func priceRangeExists() -> Bool {
        //let obj = selectedAlterationTypeRef!
        if object.minCost == object.maxCost {
            return false
        } else {
            return true
        }
    }
    
    //MARK:- View Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.title = "Add Alteration"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myAlterationStruct = AlterationStruct(object: object, uid: "", contractUID: "", dressUID: "", status: 0.0)
        populateFields()
        
        // error check values using delegate methods
        quantityField.delegate = self
        quantityField.clearButtonMode = .whileEditing
        
        actualPriceField.delegate = self
        actualPriceField.clearButtonMode = .whileEditing
        
        additionalCostField.delegate = self
        additionalCostField.clearButtonMode = .whileEditing
    }
 
}

extension AddAlterationVC: UITextFieldDelegate {
    // listing only the characters that can be used
    // https://codereview.stackexchange.com/questions/187441/prevent-a-uitextfield-from-being-input-with-aphabetic-characters
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789.")) != nil
    }

}
