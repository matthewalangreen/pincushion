//
//  Veils.swift
//  pincushion
//
//  Created by Matt Green on 5/16/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

// MARK:- Superclass
class Veils : Codable, AlterationType {
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

// MARK:- Veils subclasses
class AllCustomVeilsRequireThePurchaseOfARawEdgeVeil : Veils {
    override var name: String { return "All custom veils require the purchase of a raw edge veil" }
    override var costDetails: String { return "soft tulle: $16/yd, tulle: $10/yd" }
    override var costUnit: String { return "yard(s)" }
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
        let max: Float = 16.00
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class CordedEdge : Veils {
    override var name: String { return "Corded edge" }
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
        let min: Float = 35.00
        let max: Float = 90.00
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class HemLaceEdge : Veils {
    override var name: String { return "Hem lace edge" }
    override var costDetails: String { return "plus cost of lace & raw edge veil" }
    override var costUnit: String { return String() }
    override var units: Int { return 1 }
    override var secondaryCost: Float { return 0.0 }
    override var secondaryCostDetails: String { return "lace & raw edge cost" }
    
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
        let max: Float = 80.00
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class AppliquesVeils : Veils {
    override var name: String { return "Appliques (veils)" }
    override var costDetails: String { return "per applique, plus cost of appliques" }
    override var costUnit: String { return "applique(s)" }
    override var units: Int { return 1 }
    override var secondaryCost: Float { return 0.0 }
    override var secondaryCostDetails: String { return "cost of applique(s)" }
    
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

class Beaded : Veils {
    override var name: String { return "Beaded" }
    override var costDetails: String { return "per hour, plus cost of beads" }
    override var costUnit: String { return "hour(s)" }
    override var units: Int { return 1 }
    override var secondaryCost: Float { return 0.0 }
    override var secondaryCostDetails: String { return "beads cost" }
    
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

class RibbonEdge : Veils {
    override var name: String { return "Ribbon edge" }
    override var costDetails: String { return "plus cost of ribbon" }
    override var costUnit: String { return String() }
    override var units: Int { return 1 }
    override var secondaryCost: Float { return 0.0 }
    override var secondaryCostDetails: String { return "ribbon cost" }
    
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
        let max: Float = 50.00
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}
