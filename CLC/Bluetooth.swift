//
//  Bluetooth.swift
//  ACFC
//
//  Created by Eric Lin on 2020/11/24.
//

import CoreBluetooth

struct Peripheral: Identifiable {
    var id: UUID
    var name: String
    var peripheral: CBPeripheral
}

class BLEConnection: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate, ObservableObject {
    var centralManager: CBCentralManager!
    var peripheral: CBPeripheral!
    @Published var peripherals = [Peripheral]()
    static let instance = BLEConnection()
    let bleServiceUUID = CBUUID.init(string: "FFF0")
    let serviceUUID = CBUUID.init(string: "FFE0")
    let CH_UUID = CBUUID.init(string: "FFE1")
    var myCharacteristic: CBCharacteristic?
        
    func stopScan() {
        self.centralManager.stopScan()
    }
    
    func startCentralManager() {
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func connect(peripheral: Peripheral) {
        self.centralManager.connect(peripheral.peripheral, options: nil)
        self.peripheral = peripheral.peripheral
    }
    
    func disconnect(peripheral: Peripheral) {
        self.centralManager.cancelPeripheralConnection(peripheral.peripheral)
    }
    
    func getRSSI() {
        self.peripheral.readRSSI()
    }
    
    func sendCommand(command: String) {
        var appendDatas = [UInt8]()
        appendDatas.append(contentsOf: stringToUInt8(string: command))
        let data = Data(appendDatas)
        self.peripheral!.writeValue(data, for: self.myCharacteristic!, type: .withoutResponse)
    }
    
    func stringToUInt8(string: String) -> [UInt8] {
        let UInt8String = [UInt8](string.utf8)
        
        return UInt8String
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
            self.centralManager.scanForPeripherals(withServices: [bleServiceUUID], options: [CBCentralManagerScanOptionAllowDuplicatesKey : true])
            break
        @unknown default:
            break
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//        if let power = advertisementData[CBAdvertisementDataTxPowerLevelKey] as? Double {
//           print("Distance is ", pow(10, ((power - Double(truncating: RSSI))/20)))
//        }
//        print("Peripheral Name: \(String(describing: peripheral.name))  RSSI: \(String(RSSI.doubleValue))")
        self.centralManager.stopScan()
        print(peripheral)
        var deviceName = advertisementData[CBAdvertisementDataLocalNameKey] as? String
        deviceName = deviceName?.trimmingCharacters(in: .whitespaces)
        if deviceName != nil {
            peripherals.append(Peripheral(id: peripheral.identifier, name: deviceName!, peripheral: peripheral))
        }
    }
    
    public func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to your BLE Board")
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnect")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                if service.uuid == serviceUUID {
                    print("BLE Service found")
                    peripheral.discoverCharacteristics(nil, for: service)
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                if characteristic.uuid == CH_UUID {
                    print("Get CH_UUID")
                    self.myCharacteristic = characteristic
                    self.peripheral?.setNotifyValue(true, for: self.myCharacteristic!)
                }
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        let dataString = String(bytes: characteristic.value!, encoding: String.Encoding.utf8)
        print("Receive command: \(dataString ?? "")")
    }
    
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        let rssi = RSSI.intValue
        if rssi > -90 {
            print("Distance OK, rssi is: \(rssi)")
        }else {
            print("Distance too long, rssi is: \(rssi)")
        }
    }
    
}
