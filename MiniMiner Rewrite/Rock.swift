//
//  Rock.swift
//  MiniMiner Rewrite
//
//  Created by Elias Bickel (student LM) on 1/3/17.
//  Copyright © 2017 Pixelaborate. All rights reserved.
//

import SpriteKit
import Foundation

class Rock: SKNode{
    
    enum RockType: Int{
        case NOTHING, SOFT, MEDIUM, HARD
        
        var name: String {
            let spriteNames = [
                "",
                "SoftRock",
                "MediumRock",
                "HardRock"]
            
            return spriteNames[rawValue]
        }
    }
    
    let sprite: SKSpriteNode
    
    var type: RockType
    var occupied: Bool
    
    init(position: CGPoint, size: CGSize)
    {
        type = RockType(rawValue: Int(arc4random_uniform(3) + 1))!
        sprite = SKSpriteNode(imageNamed: type.name)
        sprite.size = size
        sprite.position = CGPoint(x: size.width / 2, y: size.height / 2)
        sprite.zRotation = .pi * CGFloat(arc4random_uniform(4))
        
        occupied = false
        
        super.init()
        
        self.position = CGPoint(x: position.x * size.width, y: position.y * size.height)
        
        addChild(sprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func breakRock()
    {
        if(type.rawValue > 0)
        {
            let particleEmitter = SKEmitterNode()
        
            addChild(particleEmitter)
            
            particleEmitter.particleBirthRate = 10000
            particleEmitter.emissionAngleRange = 6.28
            particleEmitter.numParticlesToEmit = 10
            particleEmitter.particleLifetime = 1
            particleEmitter.position = CGPoint(x: sprite.size.width / 2, y: sprite.size.height / 2)
            particleEmitter.particleTexture = SKTexture(imageNamed: type.name + "Particle")
            particleEmitter.particleScaleRange = 0.25
            particleEmitter.particleScale = 1
            particleEmitter.particleSpeed = 80
            particleEmitter.particleAlphaSpeed = -1
            particleEmitter.particleRotationRange = 40
            particleEmitter.particleRotationSpeed = 3
            particleEmitter.particleSpeedRange = 20
            particleEmitter.particleSize = CGSize(width: 60, height: 60)
            particleEmitter.zPosition = 2
            
            let wait = SKAction.wait(forDuration: 1)
            let remove = SKAction.removeFromParent()
            let sequence = SKAction.sequence([wait, remove])
            
            type = RockType(rawValue: type.rawValue - 1)!
            
            if(type.rawValue > 0){
                sprite.texture = SKTexture(imageNamed: type.name)
            }
                
            else{
                sprite.removeFromParent()
                run(sequence)
            }
        
            particleEmitter.run(sequence)
        }
    }
    
    func exists()->Bool{
        if(type.rawValue > 0){
            return true
        }
        
        return false
    }
}
