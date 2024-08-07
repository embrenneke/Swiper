//
//  SwiftGameState.swift
//  Swiper
//
//  Created by Emily Brenneke on 1/12/16.
//  Copyright © 2016 Emily Brenneke. All rights reserved.
//

import Foundation

enum GameStateError: Error {
    case incorrectCountOfDataElements
    case noEmptyTile
    case tooManyEmptyTiles
}

struct SwipeGameState<DataType : Comparable> {
    let rows : Int
    let columns : Int
    let data : [DataType?]

    init(rows: Int, columns: Int, data: [DataType?]) throws {
        self.rows = rows
        self.columns = columns
        self.data = data

        if data.count != rows * columns {
            throw GameStateError.incorrectCountOfDataElements
        }

        var blanksFound = 0
        for item in data {
            if item == nil {
                blanksFound += 1
            }
        }

        if blanksFound < 1 {
            throw GameStateError.noEmptyTile
        }

        if blanksFound > 1 {
            throw GameStateError.tooManyEmptyTiles
        }

    }

    func randomize() -> SwipeGameState<DataType> {
        var state = try! SwipeGameState(rows: rows, columns: columns, data: data)
        for _ in 1 ... rows * columns * 10 {
            var newState = state
            while newState == state {
                let tapIndex = Int(arc4random_uniform(UInt32(rows * columns)))
                newState = state.tap(tapIndex)
            }
            state = newState
        }
        return state
    }

    func swipeUp() -> SwipeGameState<DataType> {
        let indexOfBlank = blankIndex()
        if indexOfBlank + columns < data.count {
            let indexToMove = indexOfBlank + columns
            return tap(indexToMove)
        }
        return self
    }

    func swipeDown() -> SwipeGameState<DataType> {
        let indexOfBlank = blankIndex()
        if indexOfBlank >= columns {
            let indexToMove = indexOfBlank - columns
            return tap(indexToMove)
        }
        return self
    }

    func swipeLeft() -> SwipeGameState<DataType> {
        let indexOfBlank = blankIndex()
        if (indexOfBlank % columns != columns - 1) {
            let indexToMove = indexOfBlank + 1
            return tap(indexToMove)
        }
        return self
    }

    func swipeRight() -> SwipeGameState<DataType> {
        let indexOfBlank = blankIndex()
        if (indexOfBlank % columns != 0) {
            let indexToMove = indexOfBlank - 1
            return tap(indexToMove)
        }

        return self
    }

    func tap(_ indexToMove: Int) -> SwipeGameState<DataType> {
        let indexOfBlank = blankIndex()
        var valid = false

        // same row, left/right movement
        if indexToMove / columns == indexOfBlank / columns {
            if indexToMove != indexOfBlank && (indexOfBlank + indexToMove)/2 == min(indexToMove, indexOfBlank) {
                valid = true
            }
        }

        // same column, up/down movement
        if indexToMove % columns == indexOfBlank % columns {
            if indexToMove != indexOfBlank {
                let rowOfBlank = indexOfBlank / columns
                let rowToMove = indexToMove / columns
                if (rowOfBlank + rowToMove)/2 == min(rowOfBlank, rowToMove) {
                    valid = true
                }
            }
        }

        if valid {
            var replacementData = data
            swap(&replacementData[indexOfBlank], &replacementData[indexToMove])
            return try! SwipeGameState(rows: rows, columns: columns, data: replacementData)
        }

        return self
    }

    func blankIndex() -> Int {
        return data.index(where: {$0 == nil})!
    }

    func won() -> Bool {
        for index in 0 ..< data.count - 1 {
            if let left = data[index], let right = data[index + 1] , left > right {
                return false
            }
        }
        if blankIndex() != data.count - 1 {
            return false
        }
        return true
    }

}

extension SwipeGameState : Equatable {}

func ==<T : Equatable>(lhs: SwipeGameState<T>, rhs: SwipeGameState<T>) -> Bool {
    if lhs.rows != rhs.rows || lhs.rows != rhs.rows {
        return false
    }
    for (left, right) in zip(lhs.data, rhs.data) {
        if left != right {
            return false
        }
    }
    return true
}
