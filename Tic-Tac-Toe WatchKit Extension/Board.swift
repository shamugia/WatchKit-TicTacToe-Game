//
//  Board.swift
//  Tic-Tac-Toe
//
//  Created by George Shamugia on 27/11/2014.
//  Copyright (c) 2014 George Shamugia. All rights reserved.
//

import Foundation

class Board {
   
    let X = "X"
    let O = "O"
    let EMPTY_SYMBOL = " "
    let TIE = "T"
    
    let BOARD_SIZE = 9
    var boardArray:[String] = []
    
    
    init()
    {
        for i in 0 ..< self.BOARD_SIZE {
            self.boardArray.append(EMPTY_SYMBOL)
        }
    }
    
    func resetBoard()
    {
        for i in 0 ..< BOARD_SIZE
        {
            self.boardArray[i] = EMPTY_SYMBOL
        }
    }
    
    func getSymbolAtLocation(indx:Int) -> String?
    {
        if indx >= 0 && indx < self.BOARD_SIZE
        {
            return self.boardArray[indx]
        }
        else
        {
            return nil;
        }
    }
    
    func setOnBoard(symbol:String, atIndex indx:Int) -> String?
    {
        if indx >= 0 && indx < self.BOARD_SIZE && (symbol == X || symbol == O)
        {
            self.boardArray[indx] = symbol
            return winner()
        }
        else
        {
            return nil;
        }
    }
    
    func winner() -> String?
    {
        let WINNING_ROWS:[[Int]] = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        for row in 0 ..< WINNING_ROWS.count
        {
            if self.boardArray[WINNING_ROWS[row][0]] != EMPTY_SYMBOL && self.boardArray[WINNING_ROWS[row][0]] == self.boardArray[WINNING_ROWS[row][1]] && self.boardArray[WINNING_ROWS[row][1]] == self.boardArray[WINNING_ROWS[row][2]]
            {
                return self.boardArray[WINNING_ROWS[row][0]]
            }
        }
        
        for i in 0 ..< self.boardArray.count
        {
            if self.boardArray[i] == EMPTY_SYMBOL
            {
                return nil
            }
        }
        
        return self.TIE
    }
    
    func getWinningCellIndexes() -> [Int]?
    {
        let WINNING_ROWS:[[Int]] = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]
        for row in 0 ..< WINNING_ROWS.count
        {
            if self.boardArray[WINNING_ROWS[row][0]] != EMPTY_SYMBOL && self.boardArray[WINNING_ROWS[row][0]] == self.boardArray[WINNING_ROWS[row][1]] && self.boardArray[WINNING_ROWS[row][1]] == self.boardArray[WINNING_ROWS[row][2]]
            {
                return [WINNING_ROWS[row][0], WINNING_ROWS[row][1], WINNING_ROWS[row][2]]
            }
        }
        return nil
    }
    
}
