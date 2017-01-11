//
//  Item.swift
//  MiniMiner Rewrite
//
//  Created by Elias Bickel (student LM) on 1/6/17.
//  Copyright © 2017 Pixelaborate. All rights reserved.
//

import SpriteKit
import Foundation

class Item: SKNode{
    
    let itemImage: SKSpriteNode
    let itemLabel: SKLabelNode
    let itemValue: SKLabelNode
    
    let itemType: MineableType
    
    init(id: Int, numberOfItems: Int)
    {
        itemType = MineableType.all[id]
        
        itemLabel = SKLabelNode(text: "x " + String(numberOfItems))
        itemLabel.fontSize = 60
        itemLabel.position = CGPoint(x: 190, y: -45)
        itemLabel.zPosition = 3
        itemImage = SKSpriteNode(imageNamed: itemType.name)
        itemImage.size = CGSize(width: 60, height: 60)
        itemImage.position = CGPoint(x: 130, y: -30)
        itemImage.zPosition = 3
        
        itemValue = SKLabelNode(text: String(itemType.getValueAtTime(0)))
        itemValue.position = CGPoint(x: 30, y: -30)
        itemValue.fontSize = 60
        itemValue.zPosition = 3
        
        super.init()
        
        self.position = CGPoint(x: 100, y: 100)
        
        addChild(itemValue)
        addChild(itemLabel)
        addChild(itemImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(_ normalizedTime: Float){
        itemValue.text = String(itemType.getValueAtTime(0))
    }
    
}
