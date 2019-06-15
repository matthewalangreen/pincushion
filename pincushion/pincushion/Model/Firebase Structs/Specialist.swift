//
//  Specialist.swift
//  pincushion
//
//  Created by Matt Green on 5/19/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit

struct Specialist: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let uid: String
    let brides: [String] // contains Bride.uid values
    let contracts: [String] // contains contracts.uid values
}
