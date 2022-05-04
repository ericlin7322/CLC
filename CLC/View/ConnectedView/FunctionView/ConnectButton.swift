//
//  ConnectButton.swift
//  ACFC
//
//  Created by Eric Lin on 2020/11/24.
//

import SwiftUI
import CoreBluetooth

struct ConnectButton: View {
    private let ble = BLEConnection()
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        Button(action: connectBLEDevice) {
            Text("Disconnect")
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
        }.frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 4)
        .border(colorScheme == .dark ? Color.white : Color.black, width: 1)
    }
    
    private func connectBLEDevice(){
        print("connectBLEDevice")
        ble.startCentralManager()
    }
}
