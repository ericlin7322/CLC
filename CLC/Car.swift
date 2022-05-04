//
//  Car.swift
//  CLC
//
//  Created by Eric Lin on 2020/11/30.
//

import Foundation

enum Status {
    case following, unfollowing
}

struct Car {
    static var now = Car()
    var status: Status = Status.following
    var name: String = "Car Name"
    var battery: Float = 30.0
}
