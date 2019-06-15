//
//  TEMPVC.swift
//  pincushion
//
//  Created by Nicolas Haggerty on 6/1/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit

class EditAlterationVC: UIViewController {

    //MARK:- Properties
    let db = AppDelegate.shared.fsDB
    var myAlterationStruct : AlterationStruct!
    var alterationUID: String = "3.14"
    var costWasCalculated: Bool = false
    
    //MARK:- Outlets
    @IBOutlet weak var alterationDescriptionLabel: UILabel!
    @IBOutlet weak var detailsLabel: UITextField!
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var costUnitLabel: UILabel!
    @IBOutlet weak var additionalCostField: UITextField!
    @IBOutlet weak var additionalCostDetailsLabel: UILabel!
    @IBOutlet weak var totalCostLabel: UILabel!
    @IBOutlet weak var priceRangeLabel: UILabel!
    @IBOutlet weak var priceRangeDescriptionLabel: UILabel!
    @IBOutlet weak var actualPriceField: UITextField!
    
    //MARK:- Actions
    @IBAction func updateTotalAction(_ sender: Any) {
        self.costWasCalculated = true
        self.calculateCost()
    }
    
    @IBAction func addToContractAction(_ sender: Any) {
        // if totalcost hasn't been updated
        if self.costWasCalculated == false {
            let okayAlert: UIAlertController = createAlert(title: "Press: Calculate cost first", message: "Thank you", handler: {})
            self.present(okayAlert, animated: true, completion: nil)
        }
            
        // update
        else {
            let alert: UIAlertController = createCustomAlert(title: "Update Alteration?", message: "Tap cancel to verify information", confirmTitle: "Update", cancelTitle: "Cancel", confirmHandler: {
                // get updated field values from user edits
                self.getUpdatedFieldValues()
                
                // firebase code to update contents of myAlterationStruct with matching UID in firebase
                updateAlterationFBDB(db: self.db, alterationStruct: self.myAlterationStruct)
                
                self.navigationController?.popViewController(animated: true)

                var currentAlterations = ContractSingleton.current.alterations
                currentAlterations.append(self.alterationUID)
            })
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK:- Helper functions
    fileprivate func calculateCost() {
        // get new values and save them to myAlterationStruct
        myAlterationStruct.actualCost = Float(self.actualPriceField!.text!) ?? 3.14
        myAlterationStruct.units = Int(self.quantityField!.text!) ?? 314
        myAlterationStruct.secondaryCost = Float(self.additionalCostField!.text!) ?? 3.14
        
        // use a method to get total cost and then store it back into the struct
        myAlterationStruct.totalCost = myAlterationStruct.getTotalCost()
        
        // show updated value of .totalCost calculated property
        self.totalCostLabel?.text = "\(String(myAlterationStruct.totalCost))0"
    }
    
    fileprivate func getUpdatedFieldValues() {
        self.calculateCost()    
        // get all values from fields and write them to myAlterationStruct
        //let ac: Float = Float(self.actualPriceField!.text!)!
        self.myAlterationStruct.actualCost = Float(self.actualPriceField!.text!)!
        self.myAlterationStruct.costDetails = self.detailsLabel!.text!
        self.myAlterationStruct.units = Int(self.quantityField!.text!)!
        self.myAlterationStruct.secondaryCost = Float(self.additionalCostField!.text!)!
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
        
        self.alterationDescriptionLabel?.text = myAlterationStruct.name
        self.priceRangeLabel?.text = priceRangeString
        self.actualPriceField?.text = String(format: "%.0f", self.myAlterationStruct.actualCost)
        self.detailsLabel?.text = self.myAlterationStruct.costDetails
        self.quantityField?.text = String(self.myAlterationStruct.units)
        self.costUnitLabel?.text = self.myAlterationStruct.costUnit
        self.additionalCostField?.text = String(format: "%.0f", self.myAlterationStruct.secondaryCost)
        self.additionalCostDetailsLabel?.text = self.myAlterationStruct.secondaryCostDetails
        self.totalCostLabel?.text = String(format: "%.0f", self.myAlterationStruct.totalCost)
    }
    
    fileprivate func priceRangeExists() -> Bool {
        //let obj = selectedAlterationTypeRef!
        if myAlterationStruct.minCost == myAlterationStruct.maxCost {
            return false
        } else {
            return true
        }
    }
    
    //MARK:- View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //self.navigationController?.setToolbarHidden(false, animated: true)
        self.title = "Edit Alteration"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        populateFields()
        
        // catch textfield errors
        actualPriceField.delegate = self
        actualPriceField.clearButtonMode = .whileEditing
        
        quantityField.delegate = self
        quantityField.clearButtonMode = .whileEditing
        
        additionalCostField.delegate = self
        additionalCostField.clearButtonMode = .whileEditing
        
        detailsLabel.clearButtonMode = .whileEditing
    }
}

//MARK:- UITextFieldDelegate Methods
extension EditAlterationVC: UITextFieldDelegate {
    // listing only the characters that can be used
    // https://codereview.stackexchange.com/questions/187441/prevent-a-uitextfield-from-being-input-with-aphabetic-characters
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string.rangeOfCharacter(from: CharacterSet(charactersIn: "0123456789.")) != nil
    }
}


