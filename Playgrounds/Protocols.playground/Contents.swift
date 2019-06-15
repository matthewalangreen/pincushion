import UIKit

protocol MyProtocol {
    var nameSettable: String { get set }
    var nameNotSettable: String { get }
    
    func firstMethod(val: Int) -> Int
}

class FirstClass: MyProtocol {
    var nameSettable: String = "get/set"
    var nameNotSettable: String = "get"
    
    func firstMethod(vowel: Int) -> Int {
        return vowel
    }
}


var objectOne = FirstClass.init()
objectOne.nameNotSettable
objectOne.nameSettable

var objectTwo = SecondClass.init()
objectTwo.nameNotSettable
objectTwo.nameSettable
