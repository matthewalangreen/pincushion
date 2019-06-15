//
//  Singletons.swift
//  pincushion
//
//  Created by Matt Green on 5/21/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit

// Holds current contrat information
class ContractSingleton {
    static var current: Contract = Contract(
        uid: "",
        dressUID: "",
        brideUID: "",
        specialistUID: "",
        eventDate: Date.init(),
        alterations: [String()]
    )
    
    static var originalValues: Contract = Contract(
        uid: "",
        dressUID: "",
        brideUID: "",
        specialistUID: "",
        eventDate: Date.init(),
        alterations: [String()]
    )
    
}

// Holds current measurement information
class MeasurementSingleton {
    static var current: (Float,Float,Float) = (0,0,0)
}

// Holds current specialist information
class SpecialistSingleton {
    static var uid = ""
    static var displayName = ""
}


// Holds current bride information
class BrideSingleton {
    static var uid = ""
    static var fullName = ""
}
