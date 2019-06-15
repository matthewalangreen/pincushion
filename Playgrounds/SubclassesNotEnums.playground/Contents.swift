import UIKit




// MARK:- Bodice
class Bodice : Codable {
    var minCost: Float
    var maxCost: Float
    var actualCost: Float
    
    var name: String {
        let thisType = type(of: self)
        return String(describing: thisType)
    }
    
    init(minCost: Float, maxCost: Float, actualCost: Float) {
        self.minCost = minCost
        self.maxCost = maxCost
        self.actualCost = actualCost
    }
    
    convenience init() {
        self.init(minCost: -1, maxCost: -1, actualCost: -1)
    }
}

// Bodice subclasses
class AddBraCups : Bodice {
    var costDetails: String?
    
    init() {
        let min: Float = 27.00
        let max: Float = min
        let actual: Float = min
        let details: String = "includes cost of cups"
        super.init(minCost: min, maxCost: max, actualCost: actual)
        self.costDetails = details
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class AddOrRemoveBoning : Bodice {
    var costDetails: String?
    
    init() {
        let min: Float = 20.00
        let max: Float = min
        let actual: Float = min
        let details: String = "per piece"
        super.init(minCost: min, maxCost: max, actualCost: actual)
        self.costDetails = details
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class AddDarts : Bodice{
    var costDetails: String?
    
    init() {
        let min: Float = 40.00
        let max: Float = min
        let actual: Float = min
        let details: String = "each"
        super.init(minCost: min, maxCost: max, actualCost: actual)
        self.costDetails = details
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class AddBeading : Bodice {
    var costDetails: String?
    
    init() {
        let min: Float = 50.00
        let max: Float = min
        let actual: Float = min
        let details: String = "per hour / requires estimate"
        super.init(minCost: min, maxCost: max, actualCost: actual)
        self.costDetails = details
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class SewInBra : Bodice {
    var costDetails: String?
    
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
    var costDetails: String?
    
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
    var costDetails: String?
    
    init() {
        let min: Float = 45
        let max: Float = 65
        let actual: Float = min
        let details: String = "add $20 for beading / lace"
        super.init(minCost: min, maxCost: max, actualCost: actual)
        self.costDetails = details
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

class ReplaceButtonLoopTape : Bodice {
    var costDetails: String?
    
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

class AddAppliques : Bodice {
    var costDetails: String?
    
    init() {
        let min: Float = 10.00
        let max: Float = min
        let actual: Float = min
        let details: String = "per applique"
        super.init(minCost: min, maxCost: max, actualCost: actual)
        self.costDetails = details
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

struct Dress {
    var bodiceAlterations = [Bodice]()
}

var dressOne = Dress()
dressOne.bodiceAlterations.append(AddBraCups())
dressOne.bodiceAlterations.append(CloseV())

for a in dressOne.bodiceAlterations {
    print(a.actualCost)
    a.actualCost = 25.45
    print(a.actualCost)
}

var alterationOne = AddBraCups()
//alterationOne.costDetails = "per hour"
print(alterationOne.costDetails ?? "gimmie")
print(alterationOne.maxCost)



