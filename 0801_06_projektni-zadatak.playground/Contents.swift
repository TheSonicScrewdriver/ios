// Projektni zadatak
// Kenan Kahric

import Foundation

func delayedPrint(delayedString: String) {
    sleep(2)
    print(delayedString)
}

// ENUMI
enum DrivingLicenceType {
    case A
    case B
    case C
    case D
}

// PROTOKOLI
protocol DrivingLicence {
    var drivingLicenceSet: Set<DrivingLicenceType> { get set }
}

protocol CarMonitoringDelegate {
    func engineBroke()
    func lowOnFuel()
    func outOfFuel()
}

// KLASE
class Person {
    var firstName: String
    var lastName: String
    var age: Int
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
}

class Driver: Person, DrivingLicence {
    var drivingLicenceSet: Set<DrivingLicenceType>
    var car: Car?
    var mechanic: Mechanic?
    init(firstName: String, lastName: String, age: Int, drivingLicenceSet: Set<DrivingLicenceType>) {
        self.drivingLicenceSet = drivingLicenceSet
        super.init(firstName: firstName, lastName: lastName, age: age)
    }
    
    func callMechanic(mechanic: Mechanic, toFixACar car: Car){
        if mechanic.authorizedServicerForLicenceTypes.contains(car.licenceType) {
            delayedPrint("Mechanic \(mechanic.firstName) responded he can fix this car.")
            mechanic.fixCar(car)
        } else {
            delayedPrint("Mechanic \(mechanic.firstName) responded that he can't fix this car")
        }
    }
    
    func driveCar() {
        car?.drive()
    }
}

extension Driver: CarMonitoringDelegate {
    func engineBroke() {
        delayedPrint("Calling a mechanic...")
        callMechanic(mechanic!, toFixACar: car!)
    }
    func lowOnFuel() {
        if(arc4random() % 100 > 33) {
            car?.addSomeFuel()
        } else {
            delayedPrint("I will add some gas later.")
        }
    }
    func outOfFuel() {
        car?.addSomeFuel()
    }
}

class Mechanic: Person {
    var authorizedServicerForLicenceTypes: Set<DrivingLicenceType>
    init(firstName: String, lastName: String, age: Int, authorizedServicerForLicenceTypes: Set<DrivingLicenceType>) {
        self.authorizedServicerForLicenceTypes = authorizedServicerForLicenceTypes
        super.init(firstName: firstName, lastName: lastName, age: age)
    }
    func fixCar(car: Car) {
        delayedPrint("\(firstName) is fixing car")
        car.broken = false
        delayedPrint("Car fixed")
    }
}

class Car {
    var name: String
    var model: String
    var licenceType: DrivingLicenceType
    var fuelTank: Int
    private var fuel: Int = 0
    var crossedKilometers: Int = 0
    var broken = false
    var engineOn = false
    var driver: DrivingLicence?
    var delegate: CarMonitoringDelegate?
    var fuelLevel: Int {
        get {
            return fuel
        }
        set(newValue) {
            if newValue > fuelTank {
                fuel = fuelTank
            } else {
                fuel = newValue
            }
        }
    }
    
    init(name: String, model: String, licenceType: DrivingLicenceType, fuelTank: Int, fuelLevel: Int) {
        self.name = name
        self.model = model
        self.licenceType = licenceType
        self.fuelTank = fuelTank
        self.fuelLevel = fuelLevel
    }
    
    func stop() {
        delayedPrint("Engine stopped working!")
        engineOn = false
    }
    
    func drive() {
        delayedPrint("Strating engine!")
        engineOn = true
        do {
            if broken == true {
                delayedPrint("Engine broke")
                stop()
                delegate?.engineBroke()
            }
            if fuelLevel == 10 {
                delayedPrint("Low on fuel")
                delegate?.lowOnFuel()
            }
            if(fuelLevel == 0) {
                delayedPrint("Out of fuel")
                stop()
                delegate?.outOfFuel()
            }
            fuelLevel -= 1
            crossedKilometers += 10
            if(arc4random() % 100 == 100) {
                broken = true
            }
        } while (engineOn == true)
    }
    
    // uradio sam na ovaj nacin iako u zadatku ne pise tako jer smatram da je jednostavnije i cisce
    func addSomeFuel() {
        delayedPrint("Adding some fuel...")
        let randomFuel = Int(arc4random()) % (fuelTank - fuelLevel)
        fuelLevel += randomFuel
        delayedPrint("Added fuel. Current fuel level: \(fuelLevel)")
    }
}

// IMPLEMENTACIJA
let driver = Driver(firstName: "Kenan", lastName: "Kahric", age: 21, drivingLicenceSet: [DrivingLicenceType.B])
let mechanic = Mechanic(firstName: "Mirko", lastName: "Babic", age: 29, authorizedServicerForLicenceTypes: [DrivingLicenceType.A, DrivingLicenceType.B])
let car = Car(name: "Golf", model: "MK2", licenceType: DrivingLicenceType.B, fuelTank: 60, fuelLevel: 20)

driver.car = car
car.delegate = driver
driver.mechanic = mechanic

for _ in 1...10 {
    driver.driveCar()
}

delayedPrint("Car crossed \(car.crossedKilometers) kilometers.")