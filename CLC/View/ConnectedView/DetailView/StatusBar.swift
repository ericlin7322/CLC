//
//  StatusBar.swift
//  ACFC
//
//  Created by Eric Lin on 2020/11/25.
//

import SwiftUI

struct StatusBar: View {
    @Binding var name: String
    var body: some View {
        Label(name, systemImage: "bolt.horizontal.fill")
            .font(.headline)
    }
}
