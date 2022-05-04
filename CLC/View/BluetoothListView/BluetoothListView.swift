//
//  BluetoothListView.swift
//  ACFC
//
//  Created by Eric Lin on 2020/11/25.
//

import SwiftUI
import CoreMotion

struct BluetoothListView: View {
    @ObservedObject var ble = BLEConnection.instance
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            List(ble.peripherals) { peripheral in
                NavigationLink(
                    destination: ConnectedView(peripheral: peripheral), label: { Text(peripheral.name) }
                )
            }
            .navigationBarItems(trailing: Button(action: refresh) {
                Label("Reload", systemImage: "arrow.counterclockwise")
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            }
            )
            .navigationTitle("Device")
        }
    }
    
    private func refresh() {
        ble.peripherals.removeAll()
        ble.startCentralManager()
    }
}
