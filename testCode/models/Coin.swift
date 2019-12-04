//
//  Coin.swift
//  testCode
//
//  Created by David Linhares on 04/12/2019.
//  Copyright © 2019 David Linhares. All rights reserved.
//

import Foundation
import SpriteKit

class Coin: SKSpriteNode {

    // MARK: - Init

    init() {
        super.init(texture: .init(imageNamed: "unicorn"), color: .yellow, size: CGSize(width: 40, height: 40))
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        name = "\(Coin.self)"
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = false

        physicsBody?.categoryBitMask = PhysicCategory.coin
        physicsBody?.collisionBitMask = PhysicCategory.ground
        physicsBody?.contactTestBitMask = PhysicCategory.player

        physicsBody?.usesPreciseCollisionDetection = true
    }
}
