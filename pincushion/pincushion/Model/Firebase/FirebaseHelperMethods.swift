//
//  FirebaseHelperMethods.swift
//  pincushion
//
//  Created by Matt Green on 5/4/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

//MARK:- Specialist Methods
// get brides and update with new ones
func getBridesForSpecialist(uid:String, db:DatabaseReference!, newBrides: [String]){
    var serverBrides = [String]()
    
    db.child(uid).observeSingleEvent(of: .value, with: { snapshot in
        guard let value = snapshot.value else { return }
        do {
            let m = try FirebaseDecoder().decode(Specialist.self, from: value)
            serverBrides = m.brides
            serverBrides.append(contentsOf: newBrides)
            db.child(uid).child("brides").setValue(serverBrides)
            
        } catch let error {
            print(error)
        }
    })
}

func addSpecialistToFBDB(db:DatabaseReference!, uid:String, firstName:String, lastName:String, email:String, brides:[String]) {
    let specialist = Specialist(
        firstName: firstName,
        lastName: lastName,
        email: email,
        uid: uid,
        brides: brides,
        contracts: ["-1"]
    )
    let newSpecialistObject = try! FirebaseEncoder().encode(specialist)
    db.child(uid).setValue(newSpecialistObject)
}


// MARK:- Bride Methods
func addBrideToFBDB(db:DatabaseReference!, specialistUID:String, firstName:String, lastName:String, email:String, measurements:[String]) -> String {
    let bridesRef = db!
    let newBrideKey = bridesRef.childByAutoId().key!
    let bride: Bride = Bride(
        firstName: firstName,
        lastName: lastName,
        email: email,
        uid: newBrideKey,
        specialist: specialistUID,
        measurements: measurements,
        dresses: ["-1"])
    let newBrideObject = try! FirebaseEncoder().encode(bride)
    bridesRef.child(newBrideKey).setValue(newBrideObject)
    return newBrideKey
}

// MARK:- Measurement Methods
@discardableResult func addMeasurementToFBDB(db:DatabaseReference!, brideUID:String, date:Date, bust:Float, waist:Float, hip:Float) -> String {
    let ref = db!
    let newMeasurementKey = ref.childByAutoId().key!
    let measurement: Measurement = Measurement(
        bride: brideUID,
        uid: newMeasurementKey,
        date: date,
        bust: bust,
        waist: waist,
        hip: hip)
    let newMeasurementObject = try! FirebaseEncoder().encode(measurement)
    ref.child(newMeasurementKey).setValue(newMeasurementObject)
    return newMeasurementKey
}

// get measurements and update with new ones
func updateMesurementsFor(brideUID:String, db:DatabaseReference!, newMeasurementUID: String){
    var serverMeasurements = [String]()
    
    db.child("brides").child(brideUID).observeSingleEvent(of: .value, with: { snapshot in
        guard let value = snapshot.value else { return }
        do {
            let m = try FirebaseDecoder().decode(Bride.self, from: value)
            serverMeasurements = m.measurements
            serverMeasurements.append(newMeasurementUID)
            db.child("brides").child(brideUID).child("measurements").setValue(serverMeasurements)
        } catch let error {
            print("FirebaseError: \(error)")
        }
    })
}


// MARK:- Dress Methods
func addDressToFBDB(db: DatabaseReference!, invoiceNumber: Int, brideUID: String, purchaseDate: Date) -> String{
    let ref = db!
    let newDressKey = ref.childByAutoId().key!
    let dress: Dress = Dress(
        uid: newDressKey,
        invoiceNumber: invoiceNumber,
        brideUID: brideUID,
        purchaseDate: purchaseDate)
    
    let newDressObject = try! FirebaseEncoder().encode(dress)
    ref.child(newDressKey).setValue(newDressObject)
    return newDressKey
}

// MARK:- Contract Methods
func addContractToFBDB(db:DatabaseReference!, dressUID: String, brideUID:String, specialistUID: String, eventDate:Date) -> String {
    let ref = db!
    let newContractKey = ref.childByAutoId().key!
    let contract: Contract = Contract(
        uid: newContractKey,
        dressUID: dressUID,
        brideUID: brideUID,
        specialistUID: specialistUID,
        eventDate: eventDate,
        alterations: ["-1"])
   
    let newContractObject = try! FirebaseEncoder().encode(contract)
    ref.child(newContractKey).setValue(newContractObject)
    return newContractKey
}

func updateAlterationsForContract(db: DatabaseReference!, contractUID: String, newAlterationUID: String) {
    var serverAlterations = [String]()
    
    db.child("contracts").child(contractUID).observeSingleEvent(of: .value, with: { snapshot in
        guard let value = snapshot.value else { return }
        do {
            let m = try FirebaseDecoder().decode(Contract.self, from: value)
            serverAlterations = m.alterations
            serverAlterations.append(newAlterationUID)
            db.child("contracts").child(contractUID).child("alterations").setValue(serverAlterations)
        } catch let error {
            print("FirebaseError: \(error)")
        }
    })
}

//MARK:- Alteration Methods
func addAlterationToFBDB(db: DatabaseReference!, contractUID: String, alterationStruct: AlterationStruct) -> String {
    let ref = db!
    let newAlterationKey = ref.childByAutoId().key!
    var result = alterationStruct
    result.contractUID = contractUID
    result.uid = newAlterationKey
    
    let newAlterationObject = try! FirebaseEncoder().encode(result)
    ref.child(newAlterationKey).setValue(newAlterationObject)
    
    return newAlterationKey
}

// used to change the value of the alteration once it has been created in firebase
func updateAlterationFBDB(db: DatabaseReference!, alterationStruct: AlterationStruct) {
    let ref = db!.child("alterations")
    
    // get uid from alterationStruct that is being passed in
    let alterationUID = alterationStruct.uid
   
    // convert myAlterationStruct to type that can be written to fireabase
    let newAlterationObject = try! FirebaseEncoder().encode(alterationStruct)
    
    ref.child(alterationUID).setValue(newAlterationObject)
}









