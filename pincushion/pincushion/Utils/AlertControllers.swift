//
//  AlertControllers.swift
//  pincushion
//
//  Created by Matt Green on 5/1/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit

func createCustomAlert(title: String, message: String, confirmTitle: String, cancelTitle: String, confirmHandler: @escaping () -> ()) -> UIAlertController {
    
    let alertController = UIAlertController(
        title: title,
        message: message,
        preferredStyle: UIAlertController.Style.alert)
    
    let cancelAction = UIAlertAction(title: cancelTitle, style: .destructive) {
        (action) -> Void in
    }
    
    let confirmAction = UIAlertAction(title: confirmTitle, style: .default) {
        (action) -> Void in
        confirmHandler()
    }
    
    alertController.addAction(cancelAction)
    alertController.addAction(confirmAction)
    
    alertController.view.tintColor = UIColor.init(named: "Bazooka")
    
    return alertController
    
}

func createAlert(title: String, message:String, handler: @escaping ()->()) -> UIAlertController {
    let alertController = UIAlertController(
        title: title,
        message: message,
        preferredStyle: UIAlertController.Style.alert)
    
    let okayAction = UIAlertAction(title: "Okay", style: .default) {
        (action) -> Void in
        // nothing
        handler()
    }
    
    alertController.addAction(okayAction)
    alertController.view.tintColor = UIColor.init(named: "Bazooka")
    
    return alertController
}

func addBrideAlert(title: String, message:String, handler: @escaping ()->()) -> UIAlertController {
    let alertController = UIAlertController(
        title: title,
        message: message,
        preferredStyle: UIAlertController.Style.alert)
    
    let cancelAction = UIAlertAction(title: "Cancel", style: .destructive) {
        (action) -> Void in
    }
    
    let confirmAction = UIAlertAction(title: "Confirm", style: .default) {
        (action) -> Void in
        handler()
    }
    
    alertController.addAction(cancelAction)
    alertController.addAction(confirmAction)
    
    alertController.view.tintColor = UIColor.init(named: "Bazooka")
    
    return alertController
}





