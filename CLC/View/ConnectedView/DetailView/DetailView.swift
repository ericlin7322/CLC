//
//  DetailView.swift
//  ACFC
//
//  Created by Eric Lin on 2020/11/24.
//

import SwiftUI

struct DetailView: View {
    @State var battery: Float = 10.0
    @State var carName: String = "Car Name"
    @State var carStatus: String = "Status: Following"
    var body: some View {
        VStack {
            Spacer()
            NameBar(name: self.$carName)
            Spacer()
            StatusBar(name: self.$carStatus)
            Spacer()
            ProgressBar(value: self.$battery)
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
    }
}
