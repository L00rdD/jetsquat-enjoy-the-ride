//
//  Player.swift
//  testCode
//
//  Created by David Linhares on 04/12/2019.
//  Copyright © 2019 David Linhares. All rights reserved.
//

import Foundation
import SpriteKit

class Player: SKSpriteNode {
    enum State: String {
        case idle = "Idle"
        case run = "Run"
        case dead = "Dead"
    }

    private var currentState: State = .run
    private var step = 0

    // MARK: - Init
    init() {
        super.init(texture: .init(imageNamed: "Idle (1)"), color: .red, size: CGSize(width: 60, height: 70))
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        name = "\(Player.self)"
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.allowsRotation = false
        physicsBody?.isDynamic = true

        physicsBody?.categoryBitMask = PhysicCategory.player
        physicsBody?.collisionBitMask = PhysicCategory.ground
        physicsBody?.contactTestBitMask = PhysicCategory.coin | PhysicCategory.lethalObject

        physicsBody?.usesPreciseCollisionDetection = true
    }

    func setTexture(for state: State) {
        step += 1
        if state != currentState || step > 8 {
            step = 1
        }
        run(.setTexture(.init(imageNamed: "\(state.rawValue) (\(step))")))
    }
}
