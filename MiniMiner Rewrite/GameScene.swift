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
    
    let game: GameViewController
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) is not used in this app")
    }
    
    init(_ game: GameViewController) {
        
        self.game = game
        
        super.init(size: CGSize(width: 1280, height: 720))
        
        scaleMode = .fill
    }
    
    var centerScreen: CGPoint {
        get {
            let centerX = (size.width / 2)
            let centerY = (size.height / 2)
            return CGPoint(x: centerX, y: centerY)
        }
    }
}
