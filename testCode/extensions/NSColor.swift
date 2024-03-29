//
//  NSColor.swift
//  testCode
//
//  Created by David Linhares on 04/12/2019.
//  Copyright © 2019 David Linhares. All rights reserved.
//

import Foundation
import SpriteKit

extension NSColor {
    class func random() -> NSColor {
        let red =   UInt32.random(in: 0...255)
        let green = UInt32.random(in: 0...255)
        let blue =  UInt32.random(in: 0...255)
        let color = NSColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
        return color
    }
}
