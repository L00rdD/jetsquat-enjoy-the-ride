
//
//  LeatlObject.swift
//  testCode
//
//  Created by David Linhares on 04/12/2019.
//  Copyright © 2019 David Linhares. All rights reserved.
//

import Foundation
import SpriteKit

class LethalObject: SKSpriteNode {

    // MARK: - Init
    init() {
        let texture = SKTexture(imageNamed: "oil")
        let size = CGSize(width: 50, height: Bool.random() ? 70 : 140)
        super.init(texture: texture,
                   color: .systemPink,
                   size: size)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        name = "\(LethalObject.self)"
        texture?.filteringMode = .linear
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = false

        physicsBody?.categoryBitMask = PhysicCategory.lethalObject
        physicsBody?.collisionBitMask = PhysicCategory.ground
        physicsBody?.contactTestBitMask = PhysicCategory.player

        physicsBody?.usesPreciseCollisionDetection = true
    }
}
