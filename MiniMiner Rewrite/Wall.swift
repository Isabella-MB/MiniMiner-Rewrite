//
//  Wall.swift
//  MiniMiner Rewrite
//
//  Created by Elias Bickel (student LM) on 1/3/17.
//  Copyright © 2017 Pixelaborate. All rights reserved.
//

import SpriteKit
import Foundation

class Wall: SKNode{
    
    enum Tool{
        case PICKAXE, HAMMER
    }
    
    let numberOfRows = 12
    let numberOfCols = 16
    let tileDimension = 60
    
    var tool: Tool = .PICKAXE
    
    var rocks: [[Rock]]
    var mineables: [Mineable]
    
    var durability: Int
    
    override init()
    {
        durability = 100
        rocks = [[Rock]]()
        mineables = [Mineable]()
        
        for i in 0..<numberOfCols{
            rocks.append([Rock]())
            for j in 0..<numberOfRows{
                rocks[i].append(Rock(position: CGPoint(x: i, y: j), size: CGSize(width: tileDimension, height: tileDimension)))
            }
        }
        
        let numberOfMineables = arc4random_uniform(3) + 2
        
        for i in 2..<numberOfMineables{
            
            let positionX = Int(arc4random_uniform(UInt32(Int(numberOfCols - 1))))
            let positionY = Int(arc4random_uniform(UInt32(Int(numberOfRows - 1))))
            let mineable = MineableType.all[Int(arc4random_uniform(UInt32(MineableType.all.count)))]
            
            mineables.append(Mineable(position: CGPoint(x: positionX, y: positionY), tileSize: CGSize(width: tileDimension, height: tileDimension), mineableType: mineable))
        }
        
        mineables = [Mineable]()
        
        super.init()
        
        isUserInteractionEnabled = true
        
        for i in 0..<numberOfCols{
            for j in 0..<numberOfRows{
                addChild(rocks[i][j])
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(durability > 0)
        {
            for touch in touches{
                let loc = touch.location(in: self)
                
                let x: Int = Int(loc.x) / tileDimension
                let y: Int = Int(loc.y) / tileDimension
                
                if(rocks[x][y].exists()){
                    
                    rocks[x][y].breakRock()
                    durability -= 1
                
                    if(tool == .HAMMER)
                    {
                        durability -= 6
                        
                        if(x < numberOfCols - 1)
                        {
                            rocks[x + 1][y].breakRock()
                        }
                        if(y < numberOfRows - 1)
                        {
                            rocks[x][y + 1].breakRock()
                        }
                        if(x < numberOfCols - 1 && y < numberOfRows - 1)
                        {
                            rocks[x + 1][y + 1].breakRock()
                        }
                        if(x < numberOfCols - 1 && y > 0)
                        {
                            rocks[x + 1][y - 1].breakRock()
                        }
                        if(x > 0)
                        {
                            rocks[x - 1][y].breakRock()
                        }
                        if(y > 0)
                        {
                            rocks[x][y - 1].breakRock()
                        }
                        if(x > 0 && y > 0)
                        {
                            rocks[x - 1][y - 1].breakRock()
                        }
                        if(x > 0 && y < numberOfRows - 1)
                        {
                            rocks[x - 1][y + 1].breakRock()
                        }
                    }
                }
            }
        }
    }
}
