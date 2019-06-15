//
//  ReviewContractVC.swift
//  pincushion
//
//  Created by Matt Green on 5/22/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class ReviewContractVC: UITableViewController {
    let db = AppDelegate.shared.fsDB! // Firebase database ref
    var authHandle:AuthStateDidChangeListenerHandle!
    var currentUserUID = SpecialistSingleton.uid
    var alterationsUIDArray = [String]()
    
    
    @IBOutlet weak var TotalCost: UIBarButtonItem!
    
    //this
    var alterationStructArray = [AlterationStruct]()

    //MARK:- IBActions - Matt
//    @IBAction func reviewAndSignAction(_ sender: Any) {
////        print("review: ContractSingleton: \(ContractSingleton.current)\n")
////        print("review: BrideSingleton.fullName: \(BrideSingleton.fullName)\n")
////        print("review: BrideSingleton.uid: \(BrideSingleton.uid)\n")
////        print("review: MeasurementSingleton: \(MeasurementSingleton.current)\n")
//
//        let s = "SpecialistUID: \(ContractSingleton.current.specialistUID)"
//
//        makeTestPDF(viewController: self, text: s)
//    }
    
    //MARK:- IBActions - Nick H
    @IBAction func addDiscountAction(_ sender: Any) {
        print("pressed: Add Discount")
    }
    @IBAction func reviewAndSignAction(_ sender: Any) {
        //        print("review: ContractSingleton: \(ContractSingleton.current)\n")
        //        print("review: BrideSingleton.fullName: \(BrideSingleton.fullName)\n")
        //        print("review: BrideSingleton.uid: \(BrideSingleton.uid)\n")
        //        print("review: MeasurementSingleton: \(MeasurementSingleton.current)\n")
      
        let s = "SpecialistUID: \(ContractSingleton.current.specialistUID)"
        
        createContractPDF(viewController: self, text: s, AltArray: alterationStructArray, totalCost: getAlterationsTotalFloat(), brideName: BrideSingleton.fullName, specialist: CreateContractVC().getSpecialist(), eventDate: CreateContractVC().getEventDate(), buyDate: CreateContractVC().getPurchaseDate(), bust: CreateContractVC().getBust(), waist: CreateContractVC().getWaist(), hip: CreateContractVC().getHip())
    }
    
    
    //MARK:- TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alterationStructArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlterationCell", for: indexPath) as! AlterationCell
        
        let alteration = alterationStructArray[indexPath.row]
        // configure cell
//        cell.nameLabel?.text = "this is the name label for the thingie"
//        cell.subtotalLabel?.text = String(format: "%.2f", 12.34)
//        cell.totalCostDescriptionLabel?.text = "this is a long cell with cool stuff in it"
        
        cell.nameLabel?.text = alteration.name
        cell.subtotalLabel?.text = "$\(String(alteration.totalCost))0"
        
        //TODO: Change result string...
        
        var actualCostString = ""
        var secondaryCostString = ""
        var resultString = ""
        
        // there is a cost note
        if alteration.costDetails != "" {
            if alteration.units > 1 {
                actualCostString = "$\(alteration.actualCost)0 \(alteration.costDetails) (x\(alteration.units))"
            } else {
                actualCostString = "$\(alteration.actualCost)0 \(alteration.costDetails)"
            }
            
        }
       
        // there is a secondary cost & note
        if alteration.secondaryCost != 0 {
            if alteration.secondaryCostDetails != "" {
                secondaryCostString = " $\(alteration.secondaryCost)0 (\(alteration.secondaryCostDetails))"
            } else {
                secondaryCostString = " $\(alteration.secondaryCost)0"
            }
        }
        
        // if secondary cost exist, include them
        if secondaryCostString != "" {
            resultString = actualCostString + " + " + secondaryCostString
        } else {
            resultString = actualCostString
        }
        

        
        cell.totalCostDescriptionLabel?.text = "\(resultString)"
        cell.backgroundColor = Theme.current.batiste
        
        
        
        
        
        self.TotalCost.title = "Subtotal: \(getAlterationsTotal())0"

        return cell
    }

        
    
}

//MARK:- Firebase helpers
extension ReviewContractVC {
    

    fileprivate func getAlterationUIDs()  {
        //print("getContract - singletonID: \(ContractSingleton.current.uid)")
        
        // CRASH -- catch an empty string UID
        if ContractSingleton.current.uid != "" {
            db.child("contracts").child(ContractSingleton.current.uid).child("alterations").observeSingleEvent(of: .value, with: { snapshot in
                guard let value = snapshot.value as? [String] else { return }
                self.alterationsUIDArray = value
                
                self.getAlterationStructs()
            })
        }
    }
    
    fileprivate func getAlterationStructs() {
        let ref = db.child("alterations")
        self.alterationStructArray.removeAll()
        for uid in self.alterationsUIDArray {
           // print("getAlterationStructs-uid: \(uid)")
            if uid != String(-1) { // TODO: replace this with another check... this might fail?
            ref.child(uid).observeSingleEvent(of: .value, with: { snapshot in
                guard let value = snapshot.value else { return }
                // print("getAlterationStructs-value: \(value)")
                do {
                    let model = try FirebaseDecoder().decode(AlterationStruct.self, from: value)
                    self.alterationStructArray.append(model)
                    self.tableView.reloadData()
                    //print("getAlterationStructs: tableView reloaded... rowcount: \(self.alterationStructArray.count)")
                } catch let error {
                    print("CodableFirebase-Decoder() errror: \(error)")
                }
            })
            }
        }
        
    }
    

}



//MARK:- View Cycle
extension ReviewContractVC {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Review Contract"
        
        // you didn't make a contract
        if ContractSingleton.current.uid == "" {
            let alert = createAlert(title: "Please create contract first", message: "", handler: {
                self.navigationController?.popViewController(animated: true)
            })
            self.present(alert, animated: true, completion: nil)
        }
        
        // MARK: - Firebase state change handler
        authHandle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                // get current user UID
                self.currentUserUID = user!.uid
            }
        }
        
        // get alerationsStrings
        self.getAlterationUIDs()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 90 // match the height of the AlterationCell
        
        self.tableView.backgroundColor = Theme.current.batiste
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        Auth.auth().removeStateDidChangeListener(authHandle!)
    }

    func getAlterationsTotal() -> String {

        var total: Float = 0.0
        
        for calledItem in alterationStructArray {
            total = total + Float(calledItem.getTotalCost())
        }
        let toReturn: String = String(total)
       
        return "$\(toReturn)"
    }
    
    func getAlterationsTotalFloat() -> Float {
        var total: Float = 0.0
        
        for calledItem in alterationStructArray {
            total = total + Float(calledItem.getTotalCost())
        }
        //let toReturn: String = String(total)
        
        
        return total
    }



}


extension ReviewContractVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toEditAlterationVC"?:
            if let row = tableView.indexPathForSelectedRow?.row {
               // let section = tableView.indexPathForSelectedRow!.section
                // Get the item associated with this row and pass it along
                let destinationVC = segue.destination as! EditAlterationVC
                
                // AlterationType object reference... pass it on
                let object = alterationStructArray[row]
                //destinationVC.object = object
                destinationVC.myAlterationStruct = object
                
            }
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
}
