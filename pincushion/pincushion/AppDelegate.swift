//
//  AppDelegate.swift
//  pincushion
//
//  Created by Matt Green on 4/23/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // MARK:- Firebase realtime db refernce
    var fsDB: DatabaseReference!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        // MARK: - Firebase Singleton
        FirebaseApp.configure()
        fsDB = Database.database().reference()
        
        // Set the root view controller by storyboard id
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let nav = storyboard.instantiateViewController(withIdentifier: "SpecialistNavVC")
        window?.rootViewController = nav
        guard let vc = window?.rootViewController as? SpecialistNavVC else { return true }
        
        // pass this value around
        vc.fsDB = self.fsDB
      
        return true
    }
}

