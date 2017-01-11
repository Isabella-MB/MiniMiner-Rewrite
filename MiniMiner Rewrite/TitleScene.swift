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
    let resetButton: Button
    
    override init(_ game: GameViewController) {
        
        startButton = Button(position: CGPoint(x: 260, y: 256), texture: SKTexture(imageNamed: "Pickaxe"), size: CGSize(width: 256, height: 256))
        resetButton = Button(position: CGPoint(x: 780, y: 256), texture: SKTexture(imageNamed: "Hammer"), size: CGSize(width: 256, height: 256))
        
        super.init(game)
        
        addChild(startButton)
        addChild(resetButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        startButton.pressedCallback = toUndergroundScene
        resetButton.pressedCallback = resetGame
    }
    
    func resetGame(){
        for mineableType in MineableType.all
        {
            mineableType.reset()
        }
    }
    
    func toUndergroundScene()
    {
        game.ChangeScene(UndergroundScene(game), transition: SKTransition.fade(withDuration: 0.5))
    }
    
    override func update(_ currentTime: TimeInterval) {
        print(MineableType.all[0].stockName)
    }

}
