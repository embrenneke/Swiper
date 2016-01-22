//
//  GameScene.swift
//  Swiper
//
//  Created by Emily Brenneke on 12/1/15.
//  Copyright (c) 2015 Emily Brenneke. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    var gameState : SwipeGameState<Int>?
    var labels : [SKLabelNode] = []

    override func didMoveToView(view: SKView) {

        gameState = self.loadNewGame()
        self.updateBoardLocations()

        let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeUp:")
        swipeUpRecognizer.direction = .Up
        self.view?.addGestureRecognizer(swipeUpRecognizer)

        let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeDown:")
        swipeDownRecognizer.direction = .Down
        self.view?.addGestureRecognizer(swipeDownRecognizer)

        let swipeLeftRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeLeft:")
        swipeLeftRecognizer.direction = .Left
        self.view?.addGestureRecognizer(swipeLeftRecognizer)

        let swipeRightRecognizer = UISwipeGestureRecognizer(target: self, action: "swipeRight:")
        swipeRightRecognizer.direction = .Right
        self.view?.addGestureRecognizer(swipeRightRecognizer)

        let resetRecognizer = UITapGestureRecognizer(target: self, action: "doubleTap:")
        resetRecognizer.numberOfTapsRequired = 2
        self.view?.addGestureRecognizer(resetRecognizer)
    }

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }

    func updateBoardLocations() {
        self.removeChildrenInArray(labels)

        if gameState!.won() {
            let nodeLabel = SKLabelNode(fontNamed: "Chalkduster")
            nodeLabel.text = "You Won!"
            nodeLabel.fontSize = 100
            nodeLabel.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
            labels.append(nodeLabel)

            self.addChild(nodeLabel)
        } else {
            for i in 0 ..< 3 {
                for j in 0 ..< 4 {
                    if let value = gameState!.data[i*4 + j] {
                        let nodeLabel = SKLabelNode(fontNamed: "Chalkduster")
                        nodeLabel.text = "\(value)"
                        nodeLabel.fontSize = 32

                        let x = Int(self.frame.width / 4) * j + 135
                        let y = Int(self.frame.height) - (Int(self.frame.height / 3) * i + 125)
                        nodeLabel.position = CGPoint(x: x, y: y)
                        labels.append(nodeLabel)

                        self.addChild(nodeLabel)
                    }
                }
            }
        }
    }

    func swipeUp(recognizer: UISwipeGestureRecognizer) {
        print("swipeUp")
        gameState = gameState?.swipeUp()
        self.updateBoardLocations()
    }

    func swipeDown(recognizer: UISwipeGestureRecognizer) {
        print("swipeDown")
        gameState = gameState?.swipeDown()
        self.updateBoardLocations()
    }

    func swipeLeft(recognizer: UISwipeGestureRecognizer) {
        print("swipLeft")
        gameState = gameState?.swipeLeft()
        self.updateBoardLocations()
    }

    func swipeRight(recognizer: UISwipeGestureRecognizer) {
        print("swipeRight")
        gameState = gameState?.swipeRight()
        self.updateBoardLocations()
    }

    func doubleTap(recognizer: UITapGestureRecognizer) {
        print("Game Reset!")
        gameState = gameState?.randomize()
        self.updateBoardLocations()
    }

    func loadNewGame() -> SwipeGameState<Int> {
        let newGameState = SwipeGameState<Int>(rows: 3, columns: 4, data: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, nil])
        return newGameState.randomize()
    }
}
