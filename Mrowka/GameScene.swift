//
//  GameScene.swift
//  Mrowka
//
//  Created by Piotr Pawluś on 09/11/15.
//  Copyright (c) 2015 Piotr Pawluś. All rights reserved.
//

import SpriteKit

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
        upWall = createWalls().0
        midgroundNode.addChild(upWall)
        downWall = createWalls().1
        midgroundNode.addChild(downWall)
        leftWall = createWalls().2
        midgroundNode.addChild(leftWall)
        rightWall = createWalls().3
        midgroundNode.addChild(rightWall)

        // Foreground -> Add the player
        player = createPlayer()
        foregroundNode.addChild(player)
        
        // Foreground -> Points
        point = createPoints()
        foregroundNode.addChild(point)
        
        // Tap to start
        tapToStart = createTapToStart()
        hudNode.addChild(tapToStart)
        
        

        
        // CoreMotion
        
        gameOver = false
    }
    
    // MARK: - Create Walls
    func createWalls() -> (SKNode, SKNode, SKNode, SKNode) {
        let upWall = SKNode()
        let downWall = SKNode()
        let leftWall = SKNode()
        let rightWall = SKNode()
        return (upWall, downWall, leftWall, rightWall)
    }
    
    // MARKL: - Create Player
    func createPlayer() -> SKNode {
        let playerNode = SKNode()
        playerNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        
        let sprite = SKSpriteNode(imageNamed: "Player")
        playerNode.addChild(sprite)
        
        
        return playerNode
    }
    
    // MARK: - Create Point
    func createPoints() -> SKSpriteNode {
        let pointNode = SKSpriteNode()
        
        // Losowanie z wielkosci ekranu - 20.0 z przesunieciem 10.0
        pointNode.position = CGPoint(x: CGFloat(arc4random() % UInt32(frame.maxX - 20.0)) + 10.0, y: CGFloat(arc4random() % UInt32(frame.maxY - 20.0)) + 10.0 )
        print("\(pointNode.position.x) : \(pointNode.position.y)")

        let sprite = SKSpriteNode(imageNamed: "Star")
        pointNode.addChild(sprite)
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
    
}


/*

1. Fizyka do Ludzia
2. ToucheBegan do znikania taptostart
3. kolizje do ludzia i gwiazdy
4. kolizje do scian
5. akcelerometr

*/