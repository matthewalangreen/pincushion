import UIKit

// check Character is uppercase
extension Character {
    var isUpperCase: Bool { return String(self) == String(self).uppercased() }
}

// capitalize first letter
extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

// "adjustUpPriceFor" ==> "Adjust up price for"
func enumCaseToString(_ string: String) -> String {
    
    // 1. "adjustUpPriceFor" ==> ["a","d","j","u","s","t","U","p","P","r","i","c","e","F","o","r"]
    let array = Array(string)
    
    // 2. "adjustUpPriceFor" ==> [0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0]
    let positions = array.map({ c in c.isUpperCase ? 1 : 0 })
    
    // 3.  [0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0] ==> [6,2,5,3]
    func makeSubstringCounts(_ intArray: [Int]) -> [Int] {
        var substringCounts = [Int]()
        var list = intArray
        var count = 0
        while list.count > 0 {
            while list.first == 0 {
                list.removeFirst()
                count += 1
            }
            if list.count > 0 {
                substringCounts.append(count)
                list.removeFirst()
                count = 1
            } else {
                substringCounts.append(count)
            }
        }
        return substringCounts
    }
    
    // 4. [6,2,5,3] and "adjustUpPriceFor" ==> ["adjust","Up","Price","For"]
    func makeReadableString(inputString: String, substringCounts: [Int]) -> String {
        var result = [String]()
        var string = inputString
        for item in substringCounts {
            result.append(String(string.prefix(item)))
            if string.count > 0 {
                string.removeFirst(item)
            }
        }
        return result.joined(separator: " ").capitalizingFirstLetter()
    }
    
    // 5. Apply functions & return resultso
    let subCounts = makeSubstringCounts(positions)
    let result = makeReadableString(inputString: string, substringCounts: subCounts)
    return result
}

enum Hem: Int32 {
    case adjustUpPriceForBallGown = 0
    case cutEdgeTulleEtc = 1
    case satinOrSilkRolledHem = 2
    case horsehairStitchedOn = 3
    case horsehairEnclosed = 4
    case liftAndReplaceLaceApplique = 5
    case removeCrinoline = 6
    case liningSergerRolledHem = 7
    case shortenFromWaistlineAndReshapeSkirt = 8
    case addHemLace = 9
    case cutAndReplaceHem = 10
    case doubleLayerPressedEnclosedHemNoHorsehair = 11
    case pressedHemSergeEdgePressSew = 12
    case detachedLaceHemSubtract$20OfLiftAndReplacedHem = 13
}

// make readable version of case statement
extension Hem {
    var readable: String {
        return enumCaseToString(String(describing: self))
    }
}

// usage
let rawCase = Hem.detachedLaceHemSubtract$20OfLiftAndReplacedHem
Hem.cutEdgeTulleEtc
Hem.cutEdgeTulleEtc.readable









