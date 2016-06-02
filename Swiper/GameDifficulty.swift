//
//  GameDifficulty.swift
//  Swiper
//
//  Created by Emily Brenneke on 4/6/16.
//  Copyright © 2016 Emily Brenneke. All rights reserved.
//

import Foundation

enum GameDifficulty: String {
    case Beginner = "beginner"
    case Intermediate = "intermediate"
    case Advanced = "advanced"

    func rows() -> Int {
        switch self {
        case .Beginner:
            return 2
        case .Intermediate:
            return 3
        case .Advanced:
            return 4
        }
    }

    func columns() -> Int {
        switch self {
        case .Beginner:
            return 3
        case .Intermediate:
            return 4
        case .Advanced:
            return 5
        }
    }
}