//
//  ViewController.swift
//  pincushion
//
//  Created by Matt Green on 4/23/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class AddMeasurementVC: UIViewController {
    //MARK: - Properties
    var selectedBride:(String,String) = ("","") // (UID,fullName)
    var authHandle:AuthStateDidChangeListenerHandle!
    var currentUserUID:String = ""
    let db = AppDelegate.shared.fsDB
    var allMeasurements = [Measurement]()
    var myMeasurements = [Measurement]()
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .medium
        return formatter
    }()
    
    //MARK: - IBOutlets
    @IBOutlet weak var brideNameLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var bustField: UITextField!
    @IBOutlet var waistField: UITextField!
    @IBOutlet var hipField: UITextField!

    
    //MARK:- Helper functions
    fileprivate func getAllMeasurements() {
        db!.child("measurements").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [String : Any] else { return }
            do {
                let model = try FirebaseDecoder().decode([Measurement].self, from: Array(value.values))
                self.allMeasurements.removeAll()
                self.allMeasurements.append(contentsOf: model)
                self.getMyMeasurements()
                self.tableView.reloadData()
            } catch let error {
                print("CodableFirebase-Decoder() errror: \(error)")
            }
        })
    }
    
    fileprivate func getMyMeasurements() {
        myMeasurements.removeAll()
        for m in allMeasurements {
            if m.bride == selectedBride.0 {
                myMeasurements.append(m)
            }
        }
    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.brideNameLabel.text = selectedBride.1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
        // MARK: - Firebase state change handler
        authHandle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                // get current user UID
                self.currentUserUID = user!.uid
            }
        }
        getAllMeasurements()
         self.title = "Take Measurements"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        Auth.auth().removeStateDidChangeListener(authHandle!)
    }
}

//MARK: - IBActions
extension AddMeasurementVC {
    @IBAction func add(_ sender: UIButton) {
        
        let bust: Float
        let waist: Float
        let hip: Float
        
        // check to make sure that user has entered text into all fields,
        // if not, then return, which in this case means we skip
        // over all code within this method after return statement
        guard let bustString = bustField.text,
            let waistString = waistField.text,
            let hipString = hipField.text else {
                return
        }
        
        // prepare and convert placeholder String to Float
        let pBust = Float(bustField.placeholder!)
        let pWaist = Float(waistField.placeholder!)
        let pHip = Float(hipField.placeholder!)
        
        // convert the String values to Floats, if they are nil then make them equal to 1.
        // It's called the "nil-coalescing operator"
        bust = Float(bustString) ?? pBust!
        waist = Float(waistString) ?? pWaist!
        hip = Float(hipString) ?? pHip!
        
        // get measurments ref
        let measurementsRef = self.db!.child("measurements")
        
        // make new Measurement object
        let measurement = addMeasurementToFBDB(
            db: measurementsRef,
            brideUID: selectedBride.0,
            date: Date.init(),
            bust: bust,
            waist: waist,
            hip: hip)
        
        // upload to firebase
        updateMesurementsFor(brideUID: selectedBride.0, db: db, newMeasurementUID: measurement)
        
        getAllMeasurements()
        // remove input text to show placeholder
        bustField.text = ""
        waistField.text = ""
        hipField.text = ""
    }
}

// MARK: - Data source methods
extension AddMeasurementVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return myMeasurements.count
       //return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let m = myMeasurements[indexPath.row]
        let cellText = "Bust: \(m.bust), Waist: \(m.waist), Hip:\(m.hip), Date:\(m.date)"
        cell.textLabel?.text = cellText
        cell.backgroundColor = UIColor.lightGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Measurements"
    }

}
