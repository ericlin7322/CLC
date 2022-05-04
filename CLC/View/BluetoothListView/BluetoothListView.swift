//
//  BluetoothListView.swift
//  ACFC
//
//  Created by Eric Lin on 2020/11/25.
//

import SwiftUI

struct BluetoothListView: View {
    private let ble = BLEConnection()
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationView {
            List {
                NavigationLink(
                    destination: ConnectedView(),
                    label: { Text("Bluetooth1") }
                )
                NavigationLink(
                    destination: ConnectedView(),
                    label: { Text("Bluetooth2") }
                )
                NavigationLink(
                    destination: ConnectedView(),
                    label: { Text("Bluetooth3") }
                )
                NavigationLink(
                    destination: ConnectedView(),
                    label: { Text("Bluetooth4") }
                )
                NavigationLink(
                    destination: ConnectedView(),
                    label: { Text("Bluetooth5") }
                )
                NavigationLink(
                    destination: ConnectedView(),
                    label: { Text("Bluetooth6") }
                )
                NavigationLink(
                    destination: ConnectedView(),
                    label: { Text("Bluetooth7") }
                )
                NavigationLink(
                    destination: ConnectedView(),
                    label: { Text("Bluetooth8") }
                )
                NavigationLink(
                    destination: ConnectedView(),
                    label: { Text("Bluetooth9") }
                )
            }
            .navigationBarItems(trailing: Button(action: connectBLEDevice) {
                Label("Reload", systemImage: "arrow.counterclockwise")
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            }
            )
            .navigationTitle("Device")
        }
    }
    
    private func connectBLEDevice(){
        ble.startCentralManager()
    }
}
