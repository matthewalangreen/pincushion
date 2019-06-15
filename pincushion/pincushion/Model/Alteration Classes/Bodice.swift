//
//  Bodice.swift
//  pincushion
//
//  Created by Matt Green on 5/16/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//  https://stackoverflow.com/questions/56118927/enumeration-of-enumerations-and-avoiding-the-use-of-any-type

import UIKit

// MARK:- Superclass
class Bodice : Codable, AlterationType {
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

// MARK:- Bodice subclasses
class AddBraCups : Bodice {
    override var name: String { return "Add bra cups" }
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
    
    override var costDetails: String { return "includes cost of cups" }
    
    init() {
        let min: Float = 27 // 25
        let max: Float = min // min
        let actual: Float = min  // min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class AddOrRemoveBoning : Bodice {
    override var name: String { return "Add/remove boning" }
    override var costDetails: String { return "per piece" }
    override var costUnit: String { return "piece(s)" }
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

class AddDarts : Bodice{
    override var name: String { return "Add darts" }
    override var costDetails: String { return "each" }
    override var costUnit: String { return "each" }
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
        let min: Float = 40.00
        let max: Float = min
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class AddBeading : Bodice {
    override var name: String { return "Add beading" }
    override var costDetails: String { return "per hour / requires estimate" }
    override var costUnit: String { return "hour(s)" }
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
        let min: Float = 50.00
        let max: Float = min
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class SewInBra : Bodice {
    override var name: String { return "Sew in bra" }
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
        let min: Float = 30.00
        let max: Float = 60.00
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class TackOnSash : Bodice {
    override var name: String { return "Tack on sash" }
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
        let max: Float = 80.00
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class CloseV : Bodice {
    override var name: String { return "Close V" }
    override var costDetails: String { return "add $20 for beading / lace" }
    override var costUnit: String { return String() }
    override var units: Int { return 1 }
    override var secondaryCost: Float { return 20.0 }
    override var secondaryCostDetails: String { return "beading / lace cost" }
    
    override var totalCost : Float {
        get {
            return self.actualCost * Float(self.units) + self.secondaryCost
        }
        set {
            // no implementation
        }
    }
    
    init() {
        let min: Float = 45
        let max: Float = 65
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class ReplaceButtonLoopTape : Bodice {
    override var name: String { return "Replace button loop tape" }
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
        let min: Float = 40.00
        let max: Float = 50.00
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class AddAppliquesBodice : Bodice {
    override var name: String { return "Add appliques to bodice" }
    override var costDetails: String { return "per applique" }
    override var costUnit: String { return "applique(s)" }
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
        let min: Float = 10.00
        let max: Float = min
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}



