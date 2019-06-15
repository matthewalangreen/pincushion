//
//  SpecialistNavVC.swift
//  pincushion
//
//  Created by Matt Green on 5/2/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit
import Firebase

class SpecialistNavVC: UINavigationController {

    // Firestore realtime db reference --> From AppDelegate
    var fsDB: DatabaseReference!
    
    var currentUserUID:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UINavigationBar.appearance().barTintColor = Theme.current.lydian_40
        UINavigationBar.appearance().tintColor = Theme.current.essence
       // UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: Theme.current.bazooka]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        // if we haven't logged in and passed uid
        // load LoginVC
        
        //TODO: Update to use singleton
        if self.currentUserUID == "" {
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC")
            self.present(vc, animated: false, completion: nil)
        }
    }
}
