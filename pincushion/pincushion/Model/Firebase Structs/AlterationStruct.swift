//
//  Alteration.swift
//  pincushion
//
//  Created by Matt Green on 5/19/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit

struct AlterationStruct: Codable, AlterationType {
    var name: String 
    var minCost: Float
    var maxCost: Float
    var actualCost: Float
    var totalCost: Float
    var costDetails: String
    var costUnit: String
    var units: Int
    var secondaryCost: Float
    var secondaryCostDetails: String
    
    var uid: String
    var contractUID: String
    var status: Float
    
    func getTotalCost() -> Float {
        return self.actualCost * Float(self.units) + self.secondaryCost
    }
    
    init(object: AlterationType, uid: String, contractUID: String, dressUID: String, status: Float) {
        self.name = object.name
        self.minCost = object.minCost
        self.maxCost = object.maxCost
        self.actualCost = object.actualCost
        self.totalCost = 0.0 
        self.costDetails = object.costDetails
        self.costUnit = object.costUnit
        self.units = object.units
        self.secondaryCost = object.secondaryCost
        self.secondaryCostDetails = object.secondaryCostDetails
        self.uid = uid
        self.contractUID = contractUID
        self.status = status
    }
}
