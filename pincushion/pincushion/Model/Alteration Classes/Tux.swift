//
//  Tux.swift
//  pincushion
//
//  Created by Matt Green on 5/16/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//


import UIKit

// MARK:- Superclass
class Tux : Codable, AlterationType {
    var minCost: Float
    var maxCost: Float
    var actualCost: Float
    var totalCost: Float
    var costDetails: String { return String() }
    var costUnit: String { return String() }
    var units: Int  { return Int() }
    var secondaryCost: Float  { return Float() }
    var secondaryCostDetails: String  { return String() }
    
    var name: String {
        let thisType = type(of: self)
        return String(describing: thisType)
    }
    
    init(minCost: Float, maxCost: Float, actualCost: Float) {
        self.minCost = minCost
        self.maxCost = maxCost
        self.actualCost = actualCost
        self.totalCost = actualCost
    }
    
    convenience init() {
        self.init(minCost: -1, maxCost: -1, actualCost: -1)
    }
}

// MARK:- Tux subclasses
class PantsHemTux : Tux {
    override var name: String { return "Pants hem (tux)" }
    override var costUnit: String { return String() }
    override var units: Int { return 1 }
    override var secondaryCost: Float { return 0.0 }
    override var secondaryCostDetails: String { return String() }
    
    override var totalCost : Float {
        get {
            return self.actualCost * Float(self.units) + self.secondaryCost
        }
        set {
            // no implementation
        }
    }
    
    init() {
        let min: Float = 20.00
        let max: Float = min
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class JacketHemSleevesWithButtonPlacketTux : Tux {
    override var name: String { return "Jacket hem sleeves w/button placket (tux)" }
    override var costUnit: String { return String() }
    override var units: Int { return 1 }
    override var secondaryCost: Float { return 0.0 }
    override var secondaryCostDetails: String { return String() }
    
    override var totalCost : Float {
        get {
            return self.actualCost * Float(self.units) + self.secondaryCost
        }
        set {
            // no implementation
        }
    }
    
    init() {
        let min: Float = 80.00
        let max: Float = min
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
