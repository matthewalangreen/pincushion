//
//  Bride.swift
//  pincushion
//
//  Created by Matt Green on 5/19/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit

struct Bride: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let uid: String
    let specialist: String
    let measurements: [String] // contains the Measurement.uid values
    let dresses: [String] // contains dressesUID values
}

