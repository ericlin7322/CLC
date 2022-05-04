//
//  StartStopButton.swift
//  ACFC
//
//  Created by Eric Lin on 2020/11/24.
//

import SwiftUI

struct StartStopButton: View {
    @ObservedObject var ble = BLEConnection.instance
    @Environment(\.colorScheme) var colorScheme
    @State var status = Car.now.status
    let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    var body: some View {
        Button(action: {
                if status == .following {
                    status = .unfollowing
                    ble.sendCommand(command: "led_off")
                }
                else if status == .unfollowing {
                    status = .following
                    ble.sendCommand(command: "led_on")
                }
        }) {
            switch status {
            case .following:
                Label("Stop Following", systemImage: "pause.fill")
                    .foregroundColor(.red)
            case .unfollowing:
                Label("Start Following", systemImage: "play.fill")
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            }
        }
        .onReceive(timer, perform: { _ in
            if status == .following {
                self.ble.getRSSI()
            }
        })
        .font(.title)
        .frame(maxWidth: UIScreen.main.bounds.width - 50, maxHeight: UIScreen.main.bounds.height / 4)
        .overlay(Capsule(style: .circular).stroke(status == .following ? Color.red : Color.gray, lineWidth: 5))
    }
    
    func borderColor() -> Color {
        switch status {
        case .following:
            return Color.red
        case .unfollowing:
            return colorScheme == .dark ? Color.white : Color.black
        }
    }
}
