//
//  FunctionView.swift
//  ACFC
//
//  Created by Eric Lin on 2020/11/24.
//

import SwiftUI

struct FunctionView: View {
    var body: some View {
        HStack {
            Spacer()
            StartStopButton()
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height / 5)
    }
}
