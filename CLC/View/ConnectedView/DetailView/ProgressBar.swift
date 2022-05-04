//
//  ProgressBar.swift
//  ACFC
//
//  Created by Eric Lin on 2020/11/24.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var value: Float
    var body: some View {
        ZStack {
            if (Int(value) > 25) {
                Label("Battery: \(Int(value))%", systemImage: "battery.100")
                    .font(.title)
            }else {
                Label("Battery: \(Int(value))%", systemImage: "battery.25")
                    .font(.title)
            }
            
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(color())
            let circleValue = value / 100
            Circle()
                .trim(from: 0.0, to: CGFloat(circleValue))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(color())
        }.frame(width: UIScreen.main.bounds.width - 50)
    }
    
    func color() -> Color {
        if value > 40 {
            return Color.green
        }else if value > 20 {
            return Color.yellow
        }else {
            return Color.red
        }
    }
}
