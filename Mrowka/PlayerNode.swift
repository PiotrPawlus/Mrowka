//
//  PlayerSpriteNode.swift
//  Mrowka
//
//  Created by Piotr Pawluś on 11/02/16.
//  Copyright © 2016 Piotr Pawluś. All rights reserved.
//

import UIKit
import SpriteKit

class PlayerNode: SKSpriteNode {
    
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        
        self.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("Player")
    }
    
 
//    // MARKL: - Create Player
//    func createPlayer() -> SKNode {
//        let playerNode = SKNode()
//        playerNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
//        
//        let sprite = SKSpriteNode(imageNamed: "Player")
//        playerNode.addChild(sprite)
//        
//        // Physics Body
//        playerNode.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2)
//        playerNode.physicsBody?.dynamic = false
//        playerNode.physicsBody?.allowsRotation = false //true
//        playerNode.physicsBody?.restitution = 1.0
//        playerNode.physicsBody?.friction = 0.0
//        playerNode.physicsBody?.angularDamping = 0.0
//        playerNode.physicsBody?.linearDamping = 0.0
//        
//        playerNode.physicsBody?.usesPreciseCollisionDetection = true
//        playerNode.physicsBody?.categoryBitMask = CollisionCategoryBitmask.Player
//        // Don't simulate any collison
//        playerNode.physicsBody?.collisionBitMask = 0
//        playerNode.physicsBody?.contactTestBitMask = CollisionCategoryBitmask.Point | CollisionCategoryBitmask.Walls
//        return playerNode
//    }
}
