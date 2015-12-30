//
//  GameScene.swift
//  Mrowka
//
//  Created by Piotr Pawluś on 09/11/15.
//  Copyright (c) 2015 Piotr Pawluś. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // MARK: - Porperties
    /* Scens */
    var backgroundNode: SKNode!
    var midgroundNode: SKNode!
    var foregroundNode: SKNode!
    
    /* Walls */
    var upWall: SKNode!
    var downWall: SKNode!
    var leftWall: SKNode!
    var rightWall: SKNode!
    
    /* Display */
    var hudNode: SKNode!
    var labelScore: SKLabelNode!
    var tapToStart: SKSpriteNode!
    
    /* Player */
    var player: SKNode!
    var point: SKNode!
    
    /* Game over flag */
    var gameOver = false
    
    /* Acceleration */
    let motionManager = CMMotionManager()
    var xAcceleration: CGFloat = 0.0
    var yAcceleration: CGFloat = 0.0
    
    // MARK: - App Life Cycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.backgroundColor = UIColor.greenColor()
        
        // Reset
        
        /*
            1. Background ->
            2. Midground -> Walls
            3. Foreground -> Player, Points
            4. Hud -> TapToStart
            5. Gravity and a Physics Body
        */
        // Background
        backgroundNode = SKNode()
        addChild(backgroundNode)
        
        // Midground
        midgroundNode = SKNode()
        addChild(midgroundNode)
        
        // Foreground
        foregroundNode = SKNode()
        addChild(foregroundNode)
        
        // Hud
        hudNode = SKNode()
        addChild(hudNode)
        
        // Adding Gravity and a Physics Body
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2.0)
        // Set contact delegate
        physicsWorld.contactDelegate = self
        
        // Midground -> Add the walls
        downWall = setDownWall()
        midgroundNode.addChild(downWall)
        upWall = setUpWall()
        midgroundNode.addChild(upWall)
        leftWall = setLeftWall()
        midgroundNode.addChild(leftWall)
        rightWall = setRightWall()
        midgroundNode.addChild(rightWall)

        // Foreground -> Add the player
        player = createPlayer()
        foregroundNode.addChild(player)
        
        // Foreground -> Points
        point = createPoint()
        foregroundNode.addChild(point)
        
        // Tap to start
        tapToStart = createTapToStart()
        hudNode.addChild(tapToStart)
        
        

        
        // CoreMotion
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!) {
            (accelerometerData: CMAccelerometerData?, error: NSError?) in
            let acceleration = accelerometerData!.acceleration
            self.xAcceleration = (CGFloat(acceleration.x) * 0.75) + (self.xAcceleration * 0.25)
            self.yAcceleration = (CGFloat(acceleration.y) * 0.75) + (self.yAcceleration * 0.25)
        }
        
        gameOver = false
    }

    
    // MARK: - Create Walls
    func setDownWall() -> SKNode  {
        // Tworzenie dolnej sciany
        let down = SKNode()
        down.name = "wall"
        down.physicsBody = SKPhysicsBody(edgeFromPoint: CGPoint(x: CGRectGetMinX(self.frame), y: CGRectGetMinY(self.frame)), toPoint: CGPoint(x: CGRectGetMaxX(self.frame), y: CGRectGetMinY(self.frame)))
        
        down.physicsBody?.categoryBitMask = CollisionCategoryBitmask.Walls
        down.physicsBody?.contactTestBitMask = CollisionCategoryBitmask.Player
        down.physicsBody?.collisionBitMask = CollisionCategoryBitmask.Player
        return down
    }
    
    func setUpWall() -> SKNode  {
        // Tworzenie gornej sciany
        let up = SKNode()
        up.name = "wall"
        up.physicsBody = SKPhysicsBody(edgeFromPoint: CGPoint(x: CGRectGetMinX(self.frame), y: CGRectGetMaxY(self.frame)), toPoint: CGPoint(x: CGRectGetMaxX(self.frame), y: CGRectGetMaxY(self.frame)))
        
        up.physicsBody?.categoryBitMask = CollisionCategoryBitmask.Walls
        up.physicsBody?.contactTestBitMask = CollisionCategoryBitmask.Player
        up.physicsBody?.collisionBitMask = CollisionCategoryBitmask.Player
        return up
    }
    
    func setLeftWall() -> SKNode  {
        // Tworzenie lewej sciany
        let left = SKNode()
        left.name = "wall"
        left.physicsBody = SKPhysicsBody(edgeFromPoint: CGPoint(x: CGRectGetMinX(self.frame), y: CGRectGetMinY(self.frame)), toPoint: CGPoint(x: CGRectGetMinX(self.frame), y: CGRectGetMaxY(self.frame)))
        
        left.physicsBody?.categoryBitMask = CollisionCategoryBitmask.Walls
        left.physicsBody?.contactTestBitMask = CollisionCategoryBitmask.Player
        left.physicsBody?.collisionBitMask = CollisionCategoryBitmask.Player
        return left
    }
    
    func setRightWall() -> SKNode  {
        // Tworzenie lewej sciany
        let right = SKNode()
        right.name = "wall"
        right.physicsBody = SKPhysicsBody(edgeFromPoint: CGPoint(x: CGRectGetMaxX(self.frame), y: CGRectGetMinY(self.frame)), toPoint: CGPoint(x: CGRectGetMaxX(self.frame), y: CGRectGetMaxY(self.frame)))
        
        right.physicsBody?.categoryBitMask = CollisionCategoryBitmask.Walls
        right.physicsBody?.contactTestBitMask = CollisionCategoryBitmask.Player
        right.physicsBody?.collisionBitMask = CollisionCategoryBitmask.Player
        return right
    }
    
    
    
    // MARKL: - Create Player
    func createPlayer() -> SKNode {
        let playerNode = SKNode()
        playerNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        
        let sprite = SKSpriteNode(imageNamed: "Player")
        playerNode.addChild(sprite)
        
        // Physics Body
        playerNode.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2)
        playerNode.physicsBody?.dynamic = false
        playerNode.physicsBody?.allowsRotation = true //true
        
        playerNode.physicsBody?.restitution = 1.0
        playerNode.physicsBody?.friction = 0.0
        playerNode.physicsBody?.angularDamping = 0.0
        playerNode.physicsBody?.linearDamping = 0.0
        
        playerNode.physicsBody?.usesPreciseCollisionDetection = true
        playerNode.physicsBody?.categoryBitMask = CollisionCategoryBitmask.Player
        // Don't simulate any collison
        playerNode.physicsBody?.collisionBitMask = 0
        playerNode.physicsBody?.contactTestBitMask = CollisionCategoryBitmask.Point | CollisionCategoryBitmask.Walls
        
        return playerNode
    }
    
    // MARK: - Create Point
    func createPoint() -> SKSpriteNode {
        let pointNode = SKSpriteNode()
        pointNode.name = "point"
        
        // Losowanie z wielkosci ekranu - 20.0 z przesunieciem 10.0
        pointNode.position = CGPoint(x: CGFloat(arc4random() % UInt32(frame.maxX - 20.0)) + 10.0, y: CGFloat(arc4random() % UInt32(frame.maxY - 20.0)) + 10.0 )
        let sprite = SKSpriteNode(imageNamed: "Star")
        pointNode.addChild(sprite)
        
        // Physics Body 
        pointNode.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 2)
        pointNode.physicsBody?.dynamic = false
        // Colision
        pointNode.physicsBody?.categoryBitMask = CollisionCategoryBitmask.Point
        pointNode.physicsBody?.collisionBitMask = 0
        pointNode.physicsBody?.contactTestBitMask = CollisionCategoryBitmask.Player
        return pointNode
    }
    
    
    // MARKL: - Create Tap To Start Node
    func createTapToStart() -> SKSpriteNode {
        let tapToStart = SKSpriteNode()
        tapToStart.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2 + 90.0)
        
        let sprite = SKSpriteNode(imageNamed: "TapToStart")
        tapToStart.addChild(sprite)
        return tapToStart
    }
    
    // MARK: - Handling the touch
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // If player is moving do nothing else set player dynamic to true, and remove tapToStart from screen
        if !player.physicsBody!.dynamic {
            tapToStart.removeFromParent()
            player.physicsBody?.dynamic = true
        }
    }
    
    // MARK: - Handling Contact
    func didBeginContact(contact: SKPhysicsContact) {

        let wichNode = (contact.bodyA.node != player) ? contact.bodyA.node : contact.bodyB.node
        if let name = wichNode?.name {
            if name == "point" {
                wichNode?.removeFromParent()
                point = createPoint()
                foregroundNode.addChild(point)
            } else if name == "wall" {
                print("down/up wall")
            }
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        
    }
    
    // MARK: - Simulate Physics
    override func didSimulatePhysics() {
        player.physicsBody?.velocity = CGVector(dx: xAcceleration * 400, dy: yAcceleration * 400)
    }
}


/*

1. Kolizje do scian
2. Game over
3. Reset the game
4. GRAFIKA ;(
*/