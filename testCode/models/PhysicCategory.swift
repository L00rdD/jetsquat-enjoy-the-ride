//
//  PhysicCategory.swift
//  testCode
//
//  Created by David Linhares on 04/12/2019.
//  Copyright © 2019 David Linhares. All rights reserved.
//

import Foundation

struct PhysicCategory {
    static let none: UInt32         = 0
    static let player: UInt32       = 0b1
    static let ground: UInt32       = 0b10
    static let coin: UInt32         = 0b100
    static let lethalObject: UInt32 = 0b1000
}
