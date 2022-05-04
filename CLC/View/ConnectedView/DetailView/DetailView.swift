//
//  DetailView.swift
//  ACFC
//
//  Created by Eric Lin on 2020/11/24.
//

import SwiftUI

struct DetailView: View {
    @State var battery = Car.now.battery
    @State var carName = Car.now.name
    @State var carStatus = Car.now.status
    var body: some View {
        VStack {
            Spacer()
            NameBar(name: self.$carName)
            Spacer()
            StatusBar(status: self.$carStatus)
            Spacer()
            ProgressBar(value: self.$battery)
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}
