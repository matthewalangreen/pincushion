//
//  Contract.swift

//  pincushion
//
//  Created by Matt Green on 5/19/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit

struct Contract: Codable {
    var uid: String
    var dressUID: String // has measuremements
    var brideUID: String
    var specialistUID: String
    var eventDate: Date
    var alterations: [String] // alterationsUIDs
}

