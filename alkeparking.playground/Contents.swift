import UIKit
import Foundation

enum VehicleType {
    case car
    case motorcycle
    case miniBus
    case bus
    
    var fee: Int {
        switch self {
        case .car:
            return 20
        case .motorcycle:
            return 15
        case .miniBus:
            return 25
        case .bus:
            return 30
        }
    }
}

protocol Parkable {
    var plate: String { get }
    var type: VehicleType { get }
    var checkInTime: Date { get }
    var discountCard: String? { get }
    var parkedTime: Int { get }
}

struct Vehicle: Parkable, Hashable {
    let plate: String
    let type: VehicleType
    let checkInTime: Date
    let discountCard: String?
    var parkedTime: Int {
        Calendar.current.dateComponents([.minute], from: checkInTime, to: Date()).minute ?? 0
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(plate.hashValue)
    }
    
    static func == (lhs: Vehicle, rhs: Vehicle) -> Bool {
        return lhs.plate == rhs.plate
    }
}

struct Parking {
    var vehicles: Set<Vehicle> = Set()
    var maxVehicles: Int
    var report = (vehiclesNumber: 0, earnings: 0)
    
    mutating func checkInVehicle(_ vehicle: Vehicle, onFinish: (Bool) -> Void)  {
        guard vehicles.count < maxVehicles else {
            onFinish(false)
            return
        }
        
        guard !vehicles.contains(vehicle) else {
            onFinish(false)
            return
        }
        
        vehicles.insert(vehicle)
        onFinish(true)
    }
    
    mutating func checkOutVehicle(_ plate: String, onSuccess: (Int) -> Void, onError: () -> Void) {
        let vehicleToRemove = vehicles.first { vehicle in
            vehicle.plate == plate
        }
        
        if let vehicleToRemove = vehicleToRemove {
            vehicles.remove(vehicleToRemove)
            
            var finalfee = calculateFee (
                vehicleType: vehicleToRemove.type,
                parkedTime: vehicleToRemove.parkedTime
            )
            
            if hasDiscountCard(vehicle: vehicleToRemove) {
                finalfee = Int(Double(finalfee) * 0.85)
            }
            
            report.earnings += finalfee
            report.vehiclesNumber += 1
            onSuccess(finalfee)
            
        } else {
            onError()
        }
    }
    
    func calculateFee(vehicleType : VehicleType, parkedTime : Int) -> Int {
        if(parkedTime < 120) {
            return vehicleType.fee
        } else {
            let extrafeeMultiplier = Int(ceil((Double(parkedTime) - 120) / 15))
            return vehicleType.fee + (extrafeeMultiplier * 5)
        }
    }
    
    func hasDiscountCard(vehicle: Vehicle) -> Bool {
        if vehicle.discountCard != nil {
            return true
        }
        return false
    }
}

extension Parking {
    func getEarlierDate(minutes: Int) -> Date {
        let earlyDate = Calendar.current.date(
          byAdding: .minute,
          value: -minutes,
          to: Date()) ?? Date()
        return earlyDate
    }
    
    func parkingReport() {
        print("\(report.vehiclesNumber) vehicles have checked out and have earnings of $\(report.earnings)")
    }
    
    func listVehicles() {
        for vehicle in vehicles {
            print("\(vehicle.plate) is parked since \(vehicle.checkInTime).")
        }
    }
}

//MARK: - TESTES
var alkeParking = Parking(maxVehicles: 20)

var allVehicles: [Vehicle] =  [
    Vehicle(plate: "AA111AA", type: VehicleType.car, checkInTime: alkeParking.getEarlierDate(minutes: 120), discountCard: "DISCOUNT_CARD_001"),
    Vehicle(plate: "BB111BB", type: VehicleType.car, checkInTime: alkeParking.getEarlierDate(minutes: 119), discountCard: "DISCOUNT_CARD_002"),
    Vehicle(plate: "CC111CC", type: VehicleType.car, checkInTime: alkeParking.getEarlierDate(minutes: 193), discountCard: "DISCOUNT_CARD_003"),
    Vehicle(plate: "DD111DD", type: VehicleType.bus, checkInTime: alkeParking.getEarlierDate(minutes: 198), discountCard: nil),
    Vehicle(plate: "EE111EE", type: VehicleType.motorcycle, checkInTime: alkeParking.getEarlierDate(minutes: 210), discountCard: nil),
    Vehicle(plate: "FF111FF", type: VehicleType.motorcycle, checkInTime: alkeParking.getEarlierDate(minutes: 20), discountCard: nil),
    Vehicle(plate: "GG111GG", type: VehicleType.miniBus, checkInTime: alkeParking.getEarlierDate(minutes: 10), discountCard: "DISCOUNT_CARD_004"),
    Vehicle(plate: "HH111HH", type: VehicleType.bus, checkInTime: alkeParking.getEarlierDate(minutes: 10), discountCard: "DISCOUNT_CARD_005"),
    Vehicle(plate: "II111II", type: VehicleType.car, checkInTime: alkeParking.getEarlierDate(minutes: 10), discountCard: nil),
    Vehicle(plate: "JJ111JJ", type: VehicleType.motorcycle, checkInTime: alkeParking.getEarlierDate(minutes: 10), discountCard: nil),
    Vehicle(plate: "KK111KK", type: VehicleType.miniBus, checkInTime: alkeParking.getEarlierDate(minutes: 10), discountCard: nil),
    Vehicle(plate: "LL111LL", type: VehicleType.bus, checkInTime: alkeParking.getEarlierDate(minutes: 10), discountCard: "DISCOUNT_CARD_006"),
    Vehicle(plate: "MM111MM", type: VehicleType.car, checkInTime: alkeParking.getEarlierDate(minutes: 10), discountCard: "DISCOUNT_CARD_007"),
    Vehicle(plate: "NN111NN", type: VehicleType.bus, checkInTime: alkeParking.getEarlierDate(minutes: 10), discountCard: nil),
    Vehicle(plate: "OO111OO", type: VehicleType.bus, checkInTime: alkeParking.getEarlierDate(minutes: 10), discountCard: nil),
    Vehicle(plate: "PP111PP", type: VehicleType.car, checkInTime: alkeParking.getEarlierDate(minutes: 10), discountCard: nil),
    Vehicle(plate: "QQ111QQ", type: VehicleType.car, checkInTime: alkeParking.getEarlierDate(minutes: 10), discountCard: "DISCOUNT_CARD_008"),
    Vehicle(plate: "RR111RR", type: VehicleType.car, checkInTime: alkeParking.getEarlierDate(minutes: 10), discountCard: "DISCOUNT_CARD_009"),
    Vehicle(plate: "SS111SS", type: VehicleType.motorcycle, checkInTime: alkeParking.getEarlierDate(minutes: 10), discountCard: nil),
    Vehicle(plate: "TT111TT", type: VehicleType.motorcycle, checkInTime: alkeParking.getEarlierDate(minutes: 10), discountCard: "DISCOUNT_CARD_010"),
    Vehicle(plate: "UU111UU", type: VehicleType.miniBus, checkInTime: alkeParking.getEarlierDate(minutes: 10), discountCard: "DISCOUNT_CARD_011")
]

var onFinish = { vehicleInserted in
    print(vehicleInserted ? "Welcome to AlkeParking!" : "Sorry, the check-in failed!")
}
var onSuccess : (Int) -> Void = { fee in
    print("Your fee is $\(fee). Come back soon")
}
var onError: () -> Void = {
    print("Sorry, the check-out failed")
}

//Entrada dos Veiculos
for vehicle in allVehicles {
    alkeParking.checkInVehicle(vehicle, onFinish: onFinish)
}

//Listagem dos Veiculos
alkeParking.listVehicles()

//Saida dos Veiculos
for vehicle in allVehicles {
    alkeParking.checkOutVehicle(vehicle.plate, onSuccess: onSuccess, onError: onError)
}

//Calculo dos Ganhos
alkeParking.parkingReport()
