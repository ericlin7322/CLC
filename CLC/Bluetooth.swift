//
//  Bluetooth.swift
//  ACFC
//
//  Created by Eric Lin on 2020/11/24.
//

import CoreBluetooth

struct Peripheral {
    var name: String
    var peripheral: CBPeripheral
    var peripheralDelegate: CBPeripheralDelegate
    var identity: String
}

class BLEConnection: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral!
    var peripherals = [Peripheral]()
    static let instance = BLEConnection()
    
    static let bleServiceUUID = CBUUID.init(string: "FFF0")
    static let bleCharacteristicUUID = CBUUID.init(string: "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXXX")
    
    var scannedBLEDevices: [String] = []
    
    func stopScan() {
        self.centralManager.stopScan()
    }
    
    func startCentralManager() {
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch (central.state) {
        case .unsupported:
            print("BLE is Unsupported")
            break
        case .unauthorized:
            print("BLE is Unauthorized")
            break
        case .unknown:
            print("BLE is Unknown")
            break
        case .resetting:
            print("BLE is Resetting")
            break
        case .poweredOff:
            print("BLE is Powered Off")
            break
        case .poweredOn:
            print("BLE powered on")
            self.centralManager.scanForPeripherals(withServices: [BLEConnection.bleServiceUUID], options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
            break
        @unknown default:
            break
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("Peripheral Name: \(String(describing: peripheral.name))  RSSI: \(String(RSSI.doubleValue))")
        self.centralManager.stopScan()
        var deviceName = advertisementData[CBAdvertisementDataLocalNameKey] as? String
        deviceName = deviceName?.trimmingCharacters(in: .whitespaces)
        if deviceName != nil {
            peripherals.append(Peripheral(name: deviceName!, peripheral: peripheral, peripheralDelegate: self, identity: peripheral.identifier.uuidString))
//            bleManagerDelegate?.didGetBleDevices()
        }
//        self.peripheral = peripheral
//        self.scannedBLEDevices.append(peripheral.name!)
//        self.peripheral.delegate = self
//        self.centralManager.connect(self.peripheral, options: nil)
    }
    
    public func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        if peripheral == self.peripheral {
            print("Connected to your BLE Board")
            peripheral.discoverServices([BLEConnection.bleServiceUUID])
        }
    }
    
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                if service.uuid == BLEConnection.bleServiceUUID {
                    print("BLE Service found")
                    peripheral.discoverCharacteristics([BLEConnection.bleCharacteristicUUID], for: service)
                    return
                }
            }
        }
    }
    
    public func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                if characteristic.uuid == BLEConnection.bleServiceUUID {
                    print("BLE service characteristic found")
                } else {
                    print("Characteristic not found.")
                }
            }
        }
    }
    
    
}
