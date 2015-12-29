//
//  GameObjectNode.swift
//  Mrowka
//
//  Created by Piotr Pawluś on 09/11/15.
//  Copyright © 2015 Piotr Pawluś. All rights reserved.
//

import Foundation
import SpriteKit

struct CollisionCategoryBitmask {
    static let Player: UInt32 = 0x00
    static let Point: UInt32 = 0x01
    static let Walls: UInt32 = 0x02
}

class GameObjectNode: SKNode {
    
    func collisionWithPlayer(player: SKNode) -> Bool {
        self.removeFromParent()
        return false
    }
}

