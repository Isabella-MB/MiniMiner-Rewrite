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
    let item: Item
    
    var normalizedTime: Float
    
    override init(_ game: GameViewController) {
        
        undergroundBackground = SKSpriteNode(imageNamed: "UndergroundBackground")
        inventoryBackground = SKSpriteNode(imageNamed: "InventoryBackground")
        item = Item(id: 0, numberOfItems: 5)
        normalizedTime = 0
        
        super.init(game)
        
        addChild(undergroundBackground)
        addChild(inventoryBackground)
        addChild(item)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        game.ChangeScene(MiningScene(game), transition: SKTransition.fade(withDuration: 0.5))
    }
    
    override func didMove(to view: SKView) {
        undergroundBackground.position = CGPoint(x: 360, y: 360)
        inventoryBackground.position = CGPoint(x: 1000, y: 360)
    }

    override func update(_ currentTime: TimeInterval) {
        normalizedTime += 0.001
        item.update(normalizedTime)
    }
    
}
