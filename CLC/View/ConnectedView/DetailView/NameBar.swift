//
//  NameBar.swift
//  ACFC
//
//  Created by Eric Lin on 2020/11/24.
//

import SwiftUI

struct NameBar: View {
    @Binding var name: String
    var body: some View {
        Label(name, systemImage: "car")
            .font(.largeTitle)
    }
}
