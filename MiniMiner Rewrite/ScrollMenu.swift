//
//  SKScrollMenu.swift
//  MiniMiner
//
//  Created by Elias Bickel (student LM) on 12/5/16.
//  Copyright © 2016 Pixelaborate. All rights reserved.
//

import Foundation
import SpriteKit

class ScrollMenu : SKCropNode{
    
    var yStart: CGFloat
    var yLast: CGFloat
    
    let scrollSpeed: CGFloat
    let maskSize: CGSize
    let totalSize: CGSize
    
    let scrollLayer: SKSpriteNode
    
    var touchedUpInside: Bool
    
    init(position: CGPoint, size: CGSize, childNodes: [SKNode])
    {
        yStart = 0
        yLast = 0
        scrollSpeed = 1.0
        maskSize = size
        scrollLayer = SKSpriteNode(texture: nil, size: size)
        touchedUpInside = false
        
        var height = CGFloat(0);
        for child in childNodes{
            child.position.y = -height;
            scrollLayer.addChild(child)
            
            height += child.calculateAccumulatedFrame().height
        }
        
        let frameHeight = scrollLayer.calculateAccumulatedFrame().height
        totalSize = CGSize(width: size.width, height: frameHeight)
        
        super.init()
        
        self.position = position
        
        addChild(scrollLayer)
        
        let maskSprite = SKSpriteNode(texture: SKTexture(), size: size)
        maskSprite.anchorPoint = CGPoint(x: 0, y: 1)
        maskNode = maskSprite
        
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if let location = touch?.location(in: self){
            touchedUpInside = (maskNode?.contains(location))!
            
            yStart = location.y
            yLast = location.y
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self)
        
        let yDelta = (location!.y - yLast) * scrollSpeed
        
        if(touchedUpInside){
            
            if(scrollLayer.position.y + yDelta > 0 && scrollLayer.position.y + yDelta < totalSize.height - maskSize.height * 1.5){
                scrollLayer.position.y += yDelta
            }
            else if(scrollLayer.position.y + yDelta < 0){
                scrollLayer.position.y = 0
            }
            else if(scrollLayer.position.y + yDelta > totalSize.height - maskSize.height * 1.5){
                scrollLayer.position.y = totalSize.height - maskSize.height *  1.5
            }
            
            yLast = location!.y
        }
    }
}
