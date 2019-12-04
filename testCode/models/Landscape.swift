//
//  Landscape.swift
//  testCode
//
//  Created by David Linhares on 04/12/2019.
//  Copyright © 2019 David Linhares. All rights reserved.
//

import Foundation
import SpriteKit

class Landscape: SKNode {
    private let background: SKSpriteNode
    private let ground: Ground
    private let roof: Ground
    private let content = SKNode()
    private let coins = [Coin]()
    private let letalObjects = [LethalObject]()
    let size: CGSize

    // MARK: - Init

    init(size: CGSize) {
        self.size = size
        background = SKSpriteNode(texture: .init(imageNamed: "landscape1"),color: .random(), size: size)
        ground = Ground(size: CGSize(width: size.width, height: 1))
        roof = Ground(size: CGSize(width: size.width, height: 1))
        super.init()

        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        name = "\(Landscape.self)"
        ground.position.x = background.size.width / 2
        ground.position.y = ground.size.height / 2
        roof.position.x = background.size.width / 2
        roof.position.y = size.height + 1

        background.anchorPoint = CGPoint(x: 0, y: 0)

        background.zPosition = 1
        content.zPosition = 99

        addChild(background)
        addChild(content)
        addChild(ground)
        addChild(roof)
    }

    func reset() {
        content.removeAllChildren()
        background.texture = .init(imageNamed: randomLandscapeImageName())

        for _ in 0 ..< Int.random(in: 1 ..< 6) {
            let coin = Coin()
            content.addChild(coin)

            coin.position.x = CGFloat.random(in: 0 ..< size.width)
            coin.position.y = CGFloat.random(in: 0 ..< size.height)
        }

        for _ in 0 ..< Int.random(in: 1 ..< 3) {
            let letal = LethalObject()
            content.addChild(letal)

            letal.position.x = CGFloat.random(in: 0 ..< size.width)
            letal.position.y = CGFloat.random(in: 0 ..< size.height)
        }
    }

    private func randomLandscapeImageName() -> String {
        return "landscape\(Int.random(in: 1 ..< 4))"
    }
}
