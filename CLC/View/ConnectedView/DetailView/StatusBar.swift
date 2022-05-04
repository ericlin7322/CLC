//
//  StatusBar.swift
//  ACFC
//
//  Created by Eric Lin on 2020/11/25.
//

import SwiftUI

struct StatusBar: View {
    @Binding var status: Status
    var body: some View {
        switch status {
        case .following:
            Label("Status: Following", systemImage: "bolt.horizontal.fill")
                .font(.headline)
        case .unfollowing:
            Label("Status: Unfollowing", systemImage: "bolt.horizontal")
                .font(.headline)
        }
    }
}
