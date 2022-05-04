//
//  StartStopButton.swift
//  ACFC
//
//  Created by Eric Lin on 2020/11/24.
//

import SwiftUI

struct StartStopButton: View {
    @Environment(\.colorScheme) var colorScheme
    @State var status = true
    var body: some View {
        Button(action: {self.status.toggle()}) {
            if status {
                Label("Start Following", systemImage: "play.fill")
                    .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            }else {
                Label("Stop Following", systemImage: "pause.fill")
                    .foregroundColor(.red)
            }
        }
        .font(.title)
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 4)
        .border(borderColor(), width: 1)
    }
    
    func borderColor() -> Color {
        if status {
            return colorScheme == .dark ? Color.white : Color.black
        }else {
            return Color.red
        }
    }
}
