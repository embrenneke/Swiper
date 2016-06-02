//
//  GameViewController.swift
//  Swiper
//
//  Created by Emily Brenneke on 12/1/15.
//  Copyright (c) 2015 Emily Brenneke. All rights reserved.
//

import UIKit
import SpriteKit
import Crashlytics

class GameViewController: UIViewController {
    var difficulty = GameDifficulty.Beginner
    var basicResourceRequest : NSBundleResourceRequest?
    var selectedTheme : String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // TODO: conditionally check if the resource is available first, show a loading screen if it isn't
        basicResourceRequest = NSBundleResourceRequest.init(tags: [ selectedTheme ?? "basic" ])
        basicResourceRequest?.beginAccessingResourcesWithCompletionHandler({ (error) in
            if let error = error {
                // TODO: handle Error
                Crashlytics.self().recordError(error)
                print(error)
            } else {
                let images = self.basicResourceRequest?.bundle.pathsForResourcesOfType("jpg", inDirectory: nil)

                if let scene = GameScene(fileNamed: "GameScene"), images = images where images.count > 0 {
                    let index = Int(arc4random_uniform(UInt32(images.count)))
                    scene.imageName = images[index]
                    scene.difficulty = self.difficulty

                    // Configure the view.
                    let skView = self.view as! SKView
                    skView.showsFPS = true
                    skView.showsNodeCount = true

                    /* Sprite Kit applies additional optimizations to improve rendering performance */
                    skView.ignoresSiblingOrder = true

                    /* Set the scale mode to resize to fit the window */
                    scene.scaleMode = .ResizeFill

                    skView.presentScene(scene)
                }
            }
        })
    }
}
