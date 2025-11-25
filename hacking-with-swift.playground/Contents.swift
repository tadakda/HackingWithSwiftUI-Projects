import Foundation

protocol Vehicle {
    var name: String { get }
    var currentPassengers: Int { get set }
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}

struct Car: Vehicle {
    var name: String
    var currentPassengers: Int
    
    func estimateTime(for distance: Int) -> Int {
        return distance / 50
    }
    
    func travel(distance: Int) {
        print("Traveling \(distance) km in my car")
    }
}

var myCar = Car(name: "Toyota", currentPassengers: 5)
myCar.currentPassengers = 4

