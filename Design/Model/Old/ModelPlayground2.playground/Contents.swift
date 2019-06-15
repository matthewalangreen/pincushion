import UIKit

var str = "Hello, playground"

struct Measurements: CustomStringConvertible {
    var bust: Float
    var waist: Float
    var hip: Float
    var date: Date
    
    // don't call directly
    // use print(String(describing: Measurements))
    var description: String {
        return "Date: \(date) Bust: \(bust)\", Hip: \(waist)\", Inseam: \(hip)\""
    }
}

struct Cost: CustomStringConvertible {
    var amt: Float
    
    var description: String {
        return "$\(amt)"
    }
}



public class Bride {
    // Data
    var name = String()
    var measurements: [Measurements] = [Measurements.init(bust: 0, waist: 0, hip: 0, date: Date.init())]
    var cost = Cost(amt: 0.00)
    var signature = UIImage.init()
    var dressPics = [UIImage]()
    var alterationsPics = [UIImage]()
    var weddingDate = Date()
    var alterationsDueDate = Date()
    var specialist = String()
    var eventDate = Date.init()
    var notes = String()
    
    // Initializer
    
    // Methods
    
    
}

let myBride = Bride.init()
print(myBride.measurements.first)


// A bride has...
// a wedding date
// a name
// measurements
