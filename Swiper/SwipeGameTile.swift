//
//  SwipeGameTile.swift
//  Swiper
//
//  Created by Emily Brenneke on 2/9/16.
//  Copyright © 2016 Emily Brenneke. All rights reserved.
//

import UIKit

struct SwipeGameTile {
    let image : UIImage
    let tileNumber : Int

    init(image: UIImage, tileNumber: Int) {
        self.image = image
        self.tileNumber = tileNumber
    }
}

extension SwipeGameTile : Comparable {}

func ==(lhs: SwipeGameTile, rhs: SwipeGameTile) -> Bool {
    return lhs.tileNumber == rhs.tileNumber
}

func <(lhs: SwipeGameTile, rhs: SwipeGameTile) -> Bool {
    return lhs.tileNumber < rhs.tileNumber
}
