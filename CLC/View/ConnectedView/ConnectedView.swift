//
//  ConnectedView.swift
//  ACFC
//
//  Created by Eric Lin on 2020/11/25.
//

import SwiftUI
import CoreBluetooth

struct ConnectedView: View {
    @ObservedObject var ble = BLEConnection.instance
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var status = Car.now.status
    @State var showAlert = false
    var peripheral: Peripheral?
    var body: some View {
        VStack {
            Spacer()
            DetailView()
            Spacer()
            FunctionView()
            Spacer()
        }.onAppear {
            if peripheral != nil {
                ble.connect(peripheral: peripheral!)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitle("Auto Upstair Following Car", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {self.showAlert = true}) {
            Label("", systemImage: "stop.fill")
                .foregroundColor(.red)
        }
        .alert(isPresented: $showAlert, content: {
            Alert(title: Text("Disconnect the device"), message: Text("Are you sure to disconnect the device? It's will stop what you are doing."), primaryButton: .default(Text("Cancel")), secondaryButton: .destructive(Text("Disconnect"), action: disconnectBLEDevice))
        }))
        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
    }
    
    private func disconnectBLEDevice() {
        status = .unfollowing
        ble.disconnect(peripheral: peripheral!)
        self.presentationMode.wrappedValue.dismiss()
    }
}
