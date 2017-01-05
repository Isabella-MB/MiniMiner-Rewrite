//
//  GameViewController.swift
//  MiniMiner Rewrite
//
//  Created by Elias Bickel (student LM) on 1/3/17.
//  Copyright © 2017 Pixelaborate. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    var currentScene : SKScene!
    var previousScene : SKScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            currentScene = TitleScene(self)
            previousScene = currentScene
            
            view.presentScene(currentScene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    func ChangeScene(_ newScene : SKScene, transition: SKTransition)
    {
        previousScene = currentScene
        currentScene = newScene
        if let view = self.view as! SKView? {
            view.presentScene(currentScene, transition: transition)
        }
    }
    
    func ToPreviousScene(transition: SKTransition)
    {
        let temp = currentScene
        currentScene = previousScene
        if let view = self.view as! SKView? {
            view.presentScene(currentScene, transition: transition)
        }
        previousScene = temp
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
