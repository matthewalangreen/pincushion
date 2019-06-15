//
//  SpecialistHomeVC.swift
//  pincushion
//
//  Created by Matt Green on 5/2/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit
import Firebase

class SpecialistHomeVC: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        // MARK: - Hide toolbar
        self.navigationController?.setToolbarHidden(true, animated: true)

        // move to create contract vc
        self.performSegue(withIdentifier: "ShowCreateContract", sender: self)
    }
    
    @IBAction func userSettingsAction(_ sender: UIBarButtonItem) {
    }
}
