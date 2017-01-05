//
//  TitleScene.swift
//  MiniMiner Rewrite
//
//  Created by Elias Bickel (student LM) on 1/3/17.
//  Copyright © 2017 Pixelaborate. All rights reserved.
//

import SpriteKit
import Foundation

class TitleScene: GameScene{
    
    let startButton: Button
    
    override init(_ game: GameViewController) {
        
        startButton = Button(position: CGPoint(x: 128, y: 128), texture: SKTexture(imageNamed: "StartButton"), size: CGSize(width: 128, height: 128))
        
        super.init(game)
        
        addChild(startButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        startButton.pressedCallback = toUndergroundScene
    }
    
    func toUndergroundScene()
    {
        game.ChangeScene(UndergroundScene(game), transition: SKTransition.fade(withDuration: 0.5))
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
    }

}
