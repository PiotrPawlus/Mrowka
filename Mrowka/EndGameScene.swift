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
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let reveal = SKTransition.fadeWithDuration(0.5)
        let gameScene = GameScene(size: self.size)
        self.view!.presentScene(gameScene, transition: reveal)
    }

    
}
