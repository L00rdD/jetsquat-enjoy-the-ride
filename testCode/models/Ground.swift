//
//  Ground.swift
//  testCode
//
//  Created by David Linhares on 04/12/2019.
//  Copyright © 2019 David Linhares. All rights reserved.
//

import Foundation
import SpriteKit

class Ground: SKSpriteNode {

    // MARK: - Init

    init(size: CGSize) {
        super.init(texture: nil, color: .brown, size: size)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        name = "\(Ground.self)"
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = false
        physicsBody?.categoryBitMask = PhysicCategory.ground
        physicsBody?.collisionBitMask = PhysicCategory.player
        physicsBody?.contactTestBitMask = PhysicCategory.none
    }
}
