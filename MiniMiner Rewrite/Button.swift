//
//  Button.swift
//  MiniMiner Rewrite
//
//  Created by Elias Bickel (student LM) on 1/3/17.
//  Copyright © 2017 Pixelaborate. All rights reserved.
//

import Foundation
import SpriteKit

class Button: SKSpriteNode{
    
    var enabled: Bool = true
    var pressedCallback: () -> ()
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(position: CGPoint, texture : SKTexture!, size: CGSize) {
        
        pressedCallback = {() -> () in }
        
        super.init(texture: texture, color: UIColor.black, size: size)
        zPosition = 0;
        
        self.position = position
        
        isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent!)  {
        
        if (!enabled) {
            return
        }
        
        pressedCallback()
        
        run(SKAction.colorize(with: UIColor.green, colorBlendFactor: 0.5, duration: 0.01))
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent!) {
        
        if (!enabled) {
            return
        }
        
        run(SKAction.colorize(with: UIColor.white, colorBlendFactor: 1, duration: 0.01))
    }

}
