//
//  GameScene.swift
//  testCode
//
//  Created by David Linhares on 03/12/2019.
//  Copyright © 2019 David Linhares. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    private let player = Player()
    private var landscapes = [Landscape]()
    private let cameraScene = SKCameraNode()
    private var up = false
    private var alive = true
    private var lastUpdateTime: CFTimeInterval = 0
    private(set) var acceleration: CGFloat = 1.0
    private var updateNumbers = 0

    override init(size: CGSize) {
        super.init(size: size)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        isUserInteractionEnabled = true

        position(node: player, x: 300, y: 40)
        position(node: cameraScene, x: size.width / 2, y: size.height / 2)

        addChilds(nodes: [player, cameraScene])
        setupLandscapes()

        player.zPosition = 99
        
        camera = cameraScene
    }

    private func setupLandscapes() {
        for i in 0 ..< 2 {
            let landscape = Landscape(size: size)
            position(node: landscape, x: CGFloat(i) * size.width, y: 0)
            landscapes.append(landscape)
        }

        addChilds(nodes: landscapes)
    }

    private func addChilds(nodes: [SKNode]) {
        nodes.forEach { addChild($0) }
    }

    private func position(node: SKNode, x: CGFloat, y: CGFloat) {
        node.position.x = x
        node.position.y = y
    }

    // MARK: - Touches
    override func keyUp(with event: NSEvent) {
        up = false
    }

    override func keyDown(with event: NSEvent) {
        up = true
    }


    // MARK: - Update
    override func update(_ currentTime: TimeInterval) {
        if !alive {
            player.setTexture(for: .dead)
            return
        }
        updateNumbers = updateNumbers == 60 ? 0 : updateNumbers + 1

        var delta = currentTime - lastUpdateTime
        if delta > 1 {
            delta = 1 / 60
        }
        lastUpdateTime = currentTime

        checkPlayerMovements()
        player.position.x += 10 * acceleration

        cameraScene.position.x = player.position.x
        moveLandscapes()
    }

    private func moveLandscapes() {
        landscapes.forEach {
            let dx =  $0.position.x - cameraScene.position.x
            if dx < -($0.size.width + size.width / 2) {
                $0.position.x += $0.size.width * 2
                $0.reset()
            }
        }
    }

    private func checkPlayerMovements() {
        updateMoves()
        if up {
            player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 7))
            player.setTexture(for: .idle)
        }
    }

    private func updateMoves() {
        if updateNumbers % 3 == 1 {
            player.setTexture(for: .run)
        }
    }

    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
    }
}

// MARK: - Contacts

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        if !alive { return }
        let firstObject = contact.bodyA.allContactedBodies().first?.node?.name ?? ""
        let secondObject = contact.bodyB.allContactedBodies().first?.node?.name ?? ""

        if isCoinContact(first: firstObject, second: secondObject) {
            let coinBody = firstObject == "\(Coin.self)" ? contact.bodyB : contact.bodyA
            guard let coin = coinBody.node else { return }
            onPlayerTouchCoin(node: coin)
        }
    }

    func didEnd(_ contact: SKPhysicsContact) {
        if !alive { return }
        let firstObject = contact.bodyA.node?.name ?? ""
        let secondObject = contact.bodyB.node?.name ?? ""

        if isLethalContact(first: firstObject, second: secondObject) {
            onPlayerDie()
            return
        }
    }

    private func onPlayerDie() {
        acceleration = 0
        player.run(.rotate(byAngle: -.pi / 2, duration: 0.2))
        alive = false
    }

    private func onPlayerTouchCoin(node: SKNode) {
        node.removeFromParent()
    }

    private func isLethalContact(first: String, second: String) -> Bool {
        return
            !first.isEmpty && !second.isEmpty &&
            first != second &&
            (first == "\(LethalObject.self)" || first == "\(Player.self)") &&
            (second == "\(LethalObject.self)" || second == "\(Player.self)")
    }

    private func isCoinContact(first: String, second: String) -> Bool {
        return
            first != second &&
            (first == "\(Coin.self)" || first == "\(Player.self)") &&
            (second == "\(Coin.self)" || second == "\(Player.self)")
    }
}
