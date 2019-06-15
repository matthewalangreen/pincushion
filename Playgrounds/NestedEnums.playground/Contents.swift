
import UIKit

// https://developerinsider.co/advanced-enum-enumerations-by-example-swift-programming-language/
// https://docs.swift.org/swift-book/LanguageGuide/NestedTypes.html
// https://stackoverflow.com/questions/42766374/encode-nested-enumeration-swift-3

//struct Alteration {
//
//    var detail: Any
//
//
//    enum section {
//        case bodice
//        enum Bodice {
//            case addBraCups
//            case addOrRemoveBoning
//        }
//        case sides
//        enum Sides {
//            case bustTakeInOrOut
//            case hipOrWaistTakeInOrOut
//        }
//    }
//
//}
//
//var alterationOne = Alteration(detail: Alteration.section.Bodice.addBraCups)
//var alterationTwo = Alteration(detail: Alteration.section.Sides.bustTakeInOrOut)
//
//var alterations = [Any]()
//alterations.append(alterationOne)
//alterations.append(alterationTwo)
//
//alterations[1].detail

// https://stackoverflow.com/questions/56118927/enumeration-of-enumerations-and-avoiding-the-use-of-any-type
enum BodiceVariation {
    var actualPrice: Float {
        switch self {
        case .addBraCups:
            return 25
        case .addOrRemoveBoning:
            return 50
        }
    }
    
    case addBraCups
    case addOrRemoveBoning
}

enum SidesVariation {
    case bustTakeInOrOut
    case hipOrWaistTakeInOrOut
}

enum Alteration {
    
    case bodice(BodiceVariation)
    case sides(SidesVariation)
}

let alterationOne = Alteration.bodice(.addBraCups)
let alterationTwo = Alteration.sides(.bustTakeInOrOut)
let alterationThree = Alteration.sides(.hipOrWaistTakeInOrOut)

var alterations = [Alteration]()
alterations.append(alterationOne)
alterations.append(alterationTwo)
alterations.append(alterationThree)

