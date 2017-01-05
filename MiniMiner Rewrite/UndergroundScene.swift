//
//  UndergroundScene.swift
//  MiniMiner Rewrite
//
//  Created by Elias Bickel (student LM) on 1/3/17.
//  Copyright © 2017 Pixelaborate. All rights reserved.
//

import SpriteKit
import Foundation

class UndergroundScene: GameScene{
    
    let undergroundBackground: SKSpriteNode
    let inventoryBackground: SKSpriteNode
    
    override init(_ game: GameViewController) {
        
        undergroundBackground = SKSpriteNode(imageNamed: "UndergroundBackground")
        inventoryBackground = SKSpriteNode(imageNamed: "InventoryBackground")
        
        super.init(game)
        
        addChild(undergroundBackground)
        addChild(inventoryBackground)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        game.ChangeScene(MiningScene(game), transition: SKTransition.fade(withDuration: 0.5))
    }
    
    override func didMove(to view: SKView) {
        undergroundBackground.position = CGPoint(x: 480, y: 360)
        inventoryBackground.position = CGPoint(x: 1120, y: 360)
    }

    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }
    
}
