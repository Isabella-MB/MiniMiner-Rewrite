//
//  GameScene.swift
//  MiniMiner Rewrite
//
//  Created by Elias Bickel (student LM) on 1/3/17.
//  Copyright © 2017 Pixelaborate. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene : SKScene{
    let mainLayer: SKNode
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    override init() {
        mainLayer = SKNode()
        
        super.init(size: CGSize(width: 1280, height: 720))
        
        scaleMode = .fill
        addChild(mainLayer)
    }
}
