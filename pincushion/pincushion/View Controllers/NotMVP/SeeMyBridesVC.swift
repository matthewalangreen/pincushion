//
//  SeeMyBridesVC.swift
//  pincushion
//
//  Created by Matt Green on 5/3/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit
import Firebase
import CodableFirebase

class SeeMyBridesVC: UITableViewController {
    
    // MARK:- Properties
    var allBrides = [Bride]()
    var myBrides = [Bride]()
    let db = AppDelegate.shared.fsDB
    
    var authHandle:AuthStateDidChangeListenerHandle!
    var currentUserUID:String = ""
    var contractUID: String!
    
    // Helper functions
    fileprivate func getAllBrides() {
        db!.child("brides").observeSingleEvent(of: .value, with: { snapshot in
            guard let value = snapshot.value as? [String : Any] else { return }
            do {
                let model = try FirebaseDecoder().decode([Bride].self, from: Array(value.values))
                self.allBrides.removeAll()
                self.allBrides.append(contentsOf: model)
                self.getMyBrides() // filter only my brides
                self.tableView.reloadData()
            } catch let error {
                print("CodableFirebase-Decoder() errror: \(error)")
            }
        })
    }
    
    fileprivate func getMyBrides() {
        myBrides.removeAll()
        for b in allBrides {
            if b.specialist == currentUserUID {
                myBrides.append(b)
            }
        }
    }
    
    
    //MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK:- Show toolbar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setToolbarHidden(false, animated: true)
        
        // MARK: - Firebase state change handler
        authHandle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
               // get current user UID
                self.currentUserUID = user!.uid
            }
        }
        getAllBrides()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        Auth.auth().removeStateDidChangeListener(authHandle!)
    }
}

// MARK:- Data source methods
extension SeeMyBridesVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myBrides.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        let b = myBrides[indexPath.row]
        let cellText = "\(b.firstName) \(b.lastName), uid: \(b.uid)"
        cell.textLabel?.text = cellText
        cell.backgroundColor = UIColor.orange
        return cell
    }
 
}
