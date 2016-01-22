//
//  GameViewController.swift
//  Swiper
//
//  Created by Emily Brenneke on 12/1/15.
//  Copyright (c) 2015 Emily Brenneke. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        if let scene = GameScene(fileNamed: "GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }
}
