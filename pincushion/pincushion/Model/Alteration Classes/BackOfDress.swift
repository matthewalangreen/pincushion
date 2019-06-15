//
//  BackOfDress.swift
//  pincushion
//
//  Created by Matt Green on 5/16/19.
//  Copyright © 2019 Matt Green. All rights reserved.
//

import UIKit


// MARK:- Superclass
class BackOfDress : Codable, AlterationType {
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

// MARK:- BackOfDress Subclasses
class CreateKeyholeBack : BackOfDress {
    override var name: String { return "Create keyhole back" }
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
        let min: Float = 250.00
        let max: Float = min
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class LoweringBackCreatingDeepV : BackOfDress {
    override var name: String { return "Lowering back, creating deep v" }
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
        let min: Float = 60.00
        let max: Float = 120.00
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class AddCorsetBack : BackOfDress {
    override var name: String { return "Add corset back" }
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
        let min: Float = 150.00
        let max: Float = 200.00
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class ChangeToZipperBack : BackOfDress {
    override var name: String { return "Change to zipper back" }
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
        let min: Float = 90
        let max: Float = min
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class ReplaceDamagedZipper : BackOfDress {
    override var name: String { return "Replace damaged zipper" }
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
        let min: Float = 40
        let max: Float = min
        let actual: Float = min
        super.init(minCost: min, maxCost: max, actualCost: actual)
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}


