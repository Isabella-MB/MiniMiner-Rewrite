//
//  Mineable.swift
//  MiniMiner Rewrite
//
//  Created by Elias Bickel (student LM) on 1/3/17.
//  Copyright © 2017 Pixelaborate. All rights reserved.
//

import SpriteKit
import Foundation

class Mineable: SKNode {
    
    let sprite: SKSpriteNode
    let type: MineableType
    
    var revealed = false
    
    init(position: CGPoint, tileSize: CGSize, mineableType: MineableType)
    {
        type = mineableType
        
        sprite = SKSpriteNode(imageNamed: type.name)
        sprite.position = CGPoint(x: position.x * tileSize.width + type.size.width / 2, y: position.y * tileSize.height + type.size.height / 2)
        sprite.zPosition = -1
        
        super.init()
        
        addChild(sprite)
    }
    
    func reveal()
    {
        if(!revealed){
            let bulge = SKAction.scale(to: 1.1, duration: 0.05)
            let shrink = SKAction.scale(to: 0, duration: 1)
            let destroy = SKAction.removeFromParent()
            let sequence = SKAction.sequence([bulge, shrink, destroy])
            
            self.zPosition = 1
            
            run(sequence)
            
            revealed = true
        }
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
