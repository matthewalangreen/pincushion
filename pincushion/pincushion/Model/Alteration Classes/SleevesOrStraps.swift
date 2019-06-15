//
//  SleevesOrStraps.swift
//  pincushion
//
//  Created by Matt Green on 5/16/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit


// MARK:- Superclass
class SleevesOrStraps : Codable, AlterationType {
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

// MARK:- SleevesOrStraps Subclasses


class AddPremadeCapSleeves : SleevesOrStraps {
    override var name: String { return "Add premade cap sleeves" }
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
        let max: Float = 40.00
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class ConstructAndAddCapOrDropSleeves : SleevesOrStraps {
    override var name: String { return "Construct and add cap/drop sleeves" }
    override var costDetails: String { return "plus lace" }
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
        let min: Float = 85.00
        let max: Float = 100
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class AddSleeves : SleevesOrStraps {
    override var name: String { return "Add sleeves" }
    override var costDetails: String { return "plus lace" }
    override var costUnit: String { return String() }
    override var units: Int { return 1 }
    override var secondaryCost: Float { return 0.0 }
    override var secondaryCostDetails: String { return "lace cost" }
    
    override var totalCost : Float {
        get {
            return self.actualCost * Float(self.units) + self.secondaryCost
        }
        set {
            // no implementation
        }
    }
    
    init() {
        let min: Float = 250
        let max: Float = min
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class ShortenSpaghettiStraps : SleevesOrStraps {
    override var name: String { return "Shorten spaghetti straps" }
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
        let min: Float = 25.00
        let max: Float = 40.00
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class RaiseShoulders : SleevesOrStraps {
    override var name: String { return "Raise shoulders" }
    override var costDetails: String { return "add $20 for applique lace" }
    override var costUnit: String { return String() }
    override var units: Int { return 1 }
    override var secondaryCost: Float { return 20.0 }
    override var secondaryCostDetails: String { return "applique lace cost" }
    
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
        let max: Float = 50.00
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class AddPremadeStraps : SleevesOrStraps {
    override var name: String { return "Add premade straps" }
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
        let max: Float = 40.00
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class ConstructAndAddStraps : SleevesOrStraps {
    override var name: String { return "Construct and add straps" }
    override var costDetails: String { return "plus materials" }
    override var costUnit: String { return String() }
    override var units: Int { return 1 }
    override var secondaryCost: Float { return 0.0 }
    override var secondaryCostDetails: String { return "material(s) cost" }
    
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
        let max: Float = 80.00
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class ShortenOrHemSleeves : SleevesOrStraps {
    override var name: String { return "Shorten or hem sleeves" }
    override var costDetails: String { return "add $20 for applique lace" }
    override var costUnit: String { return String() }
    override var units: Int { return 1 }
    override var secondaryCost: Float { return 20.0 }
    override var secondaryCostDetails: String { return "applique lace cost" }
    
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
        let max: Float = 50.00
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class RaiseShouldersWithSleeves : SleevesOrStraps {
    override var name: String { return "Raise shoulders with sleeves" }
    override var costDetails: String { return "add $20 for applique lace" }
    override var costUnit: String { return String() }
    override var units: Int { return 1 }
    override var secondaryCost: Float { return 20.0 }
    override var secondaryCostDetails: String { return "applique lace cost" }
    
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
        let max: Float = 70.00
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class ReshapeArmholes : SleevesOrStraps {
    override var name: String { return "Reshape armholes" }
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
        let max: Float = 50.00
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class ArmscyeGusset : SleevesOrStraps {
    override var name: String { return "Armscye gusset" }
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
        let min: Float = 60.00
        let max: Float = 100.00
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class AddElasticToStraps : SleevesOrStraps {
    override var name: String { return "Add elastic to straps" }
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
        let max: Float = 50.00
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class AddHorsehairToStraps : SleevesOrStraps {
    override var name: String { return "Add horesehair to straps" }
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
        let max: Float = min
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}







