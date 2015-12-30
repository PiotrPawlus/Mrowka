//
//  EndGameScene.swift
//  Mrowka
//
//  Created by Piotr Pawluś on 30/12/15.
//  Copyright © 2015 Piotr Pawluś. All rights reserved.
//

import SpriteKit

class EndGameScene: SKScene {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)


        // Try again
        let lblTryAgain = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
        lblTryAgain.fontSize = 30
        lblTryAgain.fontColor = SKColor.whiteColor()
        lblTryAgain.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
        lblTryAgain.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
        lblTryAgain.text = "Tap To Try Again"
        addChild(lblTryAgain)
        
        
        if GameState.sharedInstance.score == GameState.sharedInstance.highScore {
            let lblMaster = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
            lblMaster.fontSize = 30
            lblMaster.fontColor = SKColor.blueColor()
            lblMaster.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2 + 120.0)
            lblMaster.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
            lblMaster.text = String(format: "YOU'RE MASTER!", GameState.sharedInstance.highScore)
            addChild(lblMaster)
            
            // High and User Score
            let lblHighScore = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
            lblHighScore.fontSize = 30
            lblHighScore.fontColor = SKColor.blueColor()
            lblHighScore.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2 + 80.0)
            lblHighScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
            lblHighScore.text = String(format: "Score: %d", GameState.sharedInstance.highScore)
            addChild(lblHighScore)
        } else {
            // User Score
            let lblUserScore = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
            lblUserScore.fontSize = 30
            lblUserScore.fontColor = SKColor.redColor()
            lblUserScore.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2 - 80.0)
            lblUserScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
            lblUserScore.text = "Your score: \(GameState.sharedInstance.score)"
            addChild(lblUserScore)
            
            
            // High Score
            let lblHighScore = SKLabelNode(fontNamed: "ChalkboardSE-Bold")
            lblHighScore.fontSize = 30
            lblHighScore.fontColor = SKColor.blueColor()
            lblHighScore.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2 + 80.0)
            lblHighScore.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Center
            lblHighScore.text = String(format: "High Score: %d", GameState.sharedInstance.highScore)
            addChild(lblHighScore)
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let reveal = SKTransition.fadeWithDuration(0.5)
        let gameScene = GameScene(size: self.size)
        self.view!.presentScene(gameScene, transition: reveal)
    }

    
}
