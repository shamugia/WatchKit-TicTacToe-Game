//
//  InterfaceController.swift
//  Tic-Tac-Toe WatchKit Extension
//
//  Created by George Shamugia on 26/11/2014.
//  Copyright (c) 2014 George Shamugia. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var boardBg:WKInterfaceGroup!
    @IBOutlet weak var introAnimImg:WKInterfaceImage!
    @IBOutlet weak var gameBoard:WKInterfaceGroup!
    
    @IBOutlet weak var btn1:WKInterfaceButton!
    @IBOutlet weak var btn2:WKInterfaceButton!
    @IBOutlet weak var btn3:WKInterfaceButton!
    @IBOutlet weak var btn4:WKInterfaceButton!
    @IBOutlet weak var btn5:WKInterfaceButton!
    @IBOutlet weak var btn6:WKInterfaceButton!
    @IBOutlet weak var btn7:WKInterfaceButton!
    @IBOutlet weak var btn8:WKInterfaceButton!
    @IBOutlet weak var btn9:WKInterfaceButton!
    
    let arrayOfBtns:[WKInterfaceButton] = []
    
    let xoBoard:Board = Board()
    
    var userSymbol = ""
    var opponentSymbol  = ""
    var turn = ""
    
    var isFirstLaunch = true
    
    
    override init(context: AnyObject?) {
        super.init(context: context)
        
        arrayOfBtns = [btn1, btn2, btn3, btn4, btn5, btn6, btn7, btn8, btn9]
        
        boardBg.setHidden(false)
        gameBoard.setHidden(true)
        
        if WKInterfaceDevice.currentDevice().screenBounds.size.width > 136.0    //42mm
        {
            boardBg.setBackgroundImageNamed("42_boardbg")
            gameBoard.setBackgroundImageNamed("42_boardbg")
        }
        else
        {
            boardBg.setBackgroundImageNamed("38_boardbg")
            gameBoard.setBackgroundImageNamed("38_boardbg")
        }
    }

    override func willActivate() {
        super.willActivate()
        
        if isFirstLaunch
        {
            playIntroAnimation()
        }
        else
        {
            newGame()
        }
        isFirstLaunch = false
    }

    override func didDeactivate() {
        NSLog("%@ did deactivate", self)
        super.didDeactivate()
    }
    
    @IBAction func restartGame() {
        newGame()
    }
    
    @IBAction func btn0Tapped() {
        let btnIndex = 0
        didTappButtonWithIndex(btnIndex)
    }

    @IBAction func btn1Tapped() {
        let btnIndex = 1
        didTappButtonWithIndex(btnIndex)
    }
    
    @IBAction func btn2Tapped() {
        let btnIndex = 2
        didTappButtonWithIndex(btnIndex)
    }
    
    @IBAction func btn3Tapped() {
        let btnIndex = 3
        didTappButtonWithIndex(btnIndex)
    }
    
    @IBAction func btn4Tapped() {
        let btnIndex = 4
        didTappButtonWithIndex(btnIndex)
    }
    
    @IBAction func btn5Tapped() {
        let btnIndex = 5
        didTappButtonWithIndex(btnIndex)
    }
    
    @IBAction func btn6Tapped() {
        let btnIndex = 6
        didTappButtonWithIndex(btnIndex)
    }
    
    @IBAction func btn7Tapped() {
        let btnIndex = 7
        didTappButtonWithIndex(btnIndex)
    }
    
    @IBAction func btn8Tapped() {
        let btnIndex = 8
        didTappButtonWithIndex(btnIndex)
    }
    
    func didTappButtonWithIndex(indx:Int)
    {
        if let sym = xoBoard.getSymbolAtLocation(indx)
        {
            if sym == xoBoard.EMPTY_SYMBOL
            {
                lockTheBoard()
                let btn = arrayOfBtns[indx] as WKInterfaceButton
                btn.setTitle(userSymbol)
                if let res = xoBoard.setOnBoard(userSymbol, atIndex: indx)
                {
                    gameOver(res)
                }
                else
                {
                    turn = (userSymbol == xoBoard.X) ? xoBoard.O : xoBoard.X
                    nextTurn()
                }
            }
        }
    }
    
    func playIntroAnimation()
    {
        if WKInterfaceDevice.currentDevice().screenBounds.size.width > 136.0    //42mm
        {
            self.introAnimImg.setImageNamed("42_anim")
        }
        else
        {
            self.introAnimImg.setImageNamed("38_anim")
        }
        self.introAnimImg.startAnimatingWithImagesInRange(NSMakeRange(0, 29), duration: 3.0, repeatCount: 1)
        
        NSTimer.scheduledTimerWithTimeInterval(3.5, target: self, selector: Selector("showGameBoard"), userInfo: nil, repeats: false)
    }
    
    func showGameBoard()
    {
        boardBg.setHidden(true)
        gameBoard.setHidden(false)
        newGame()
    }
    
    func newGame()
    {
        clearTheBoard()
        userSymbol = getUsersSymbol()
        opponentSymbol = (userSymbol == xoBoard.X) ? xoBoard.O : xoBoard.X
        turn = xoBoard.X
        nextTurn()
    }
    
    func clearTheBoard()
    {
        for item in arrayOfBtns
        {
            let btn = item as WKInterfaceButton
            btn.setTitle(xoBoard.EMPTY_SYMBOL)
            btn.setEnabled(false)
        }
        xoBoard.resetBoard()
    }
    
    func getUsersSymbol() -> String
    {
        return ((arc4random_uniform(2) == 1) ? xoBoard.X : xoBoard.O)
    }
    
    func nextTurn()
    {
        if userSymbol == turn
        {
            for i in 0 ..< xoBoard.BOARD_SIZE
            {
                if xoBoard.getSymbolAtLocation(i) == xoBoard.EMPTY_SYMBOL
                {
                    var btn = arrayOfBtns[i] as WKInterfaceButton
                    btn.setEnabled(true)
                }
            }
        }
        else
        {
            opponentPlay()
        }
    }
    
    func lockTheBoard()
    {
        for item in arrayOfBtns
        {
            let btn = item as WKInterfaceButton
            btn.setEnabled(false)
        }
    }
    
    func opponentPlay()
    {
        var move = findOpponentMove()
        var btn = arrayOfBtns[move] as WKInterfaceButton
        btn.setTitle(opponentSymbol)
        if let res = xoBoard.setOnBoard(opponentSymbol, atIndex: move)
        {
            gameOver(res)
        }
        else
        {
            turn = (opponentSymbol == xoBoard.X) ? xoBoard.O : xoBoard.X
            nextTurn()
        }
    }
    
    func findOpponentMove() -> Int
    {
        var move = 0
        var found = false
        
        while !found && move < xoBoard.BOARD_SIZE
        {
            if xoBoard.boardArray[move] == xoBoard.EMPTY_SYMBOL
            {
                xoBoard.boardArray[move] = opponentSymbol
                if let w = xoBoard.winner()
                {
                    if w == opponentSymbol
                    {
                        found = true;
                    }
                }
                xoBoard.boardArray[move] = xoBoard.EMPTY_SYMBOL
            }
            if !found {
                move++
            }
        }
        
        if !found
        {
            move = 0
            while !found && move < xoBoard.BOARD_SIZE
            {
                if xoBoard.boardArray[move] == xoBoard.EMPTY_SYMBOL
                {
                    xoBoard.boardArray[move] = userSymbol
                    if let w = xoBoard.winner()
                    {
                        if w == userSymbol
                        {
                            found = true;
                        }
                    }
                    xoBoard.boardArray[move] = xoBoard.EMPTY_SYMBOL
                }
                if !found {
                    move++
                }
            }
        }
        
        if !found
        {
            move = 0
            var i = 0
            let BEST_MOVES:[Int] = [4, 0, 2, 6, 8, 1, 3, 5, 7]
            while !found && i < BEST_MOVES.count
            {
                move = BEST_MOVES[i]
                if xoBoard.boardArray[move] == xoBoard.EMPTY_SYMBOL
                {
                    found = true
                }
                i++
            }
        }
        
        return move
    }
    
    func gameOver(winner:String)
    {
        if winner != xoBoard.TIE
        {
            if let winningCells = xoBoard.getWinningCellIndexes()
            {
                for i in 0 ..< winningCells.count
                {
                    var btn = arrayOfBtns[winningCells[i]] as WKInterfaceButton
                    var attrTitle = NSAttributedString(string: winner, attributes: [NSForegroundColorAttributeName:UIColor.redColor()])
                    btn.setAttributedTitle(attrTitle)
                }
            }
        }
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("displayResultScreen:"), userInfo: winner, repeats: false)
    }
    
    func displayResultScreen(timer: NSTimer)
    {
        var winner = timer.userInfo as String
        var userdef = NSUserDefaults.standardUserDefaults()
        var winValue:Int = 0
        var loseValue:Int = 0
        
        if let win = userdef.objectForKey("RESULT_WIN") as? NSNumber
        {
            winValue = win.integerValue
        }
        if let lose = userdef.objectForKey("RESULT_LOSE") as? NSNumber
        {
            loseValue = lose.integerValue
        }
        
        var winText = ""
        switch winner
        {
            case userSymbol:
                winText = "You win!"
                winValue++
            case opponentSymbol:
                winText = "You lose!"
                loseValue++
            default: winText = "Tie"
        }
        
        userdef.setObject(NSNumber(integer: winValue), forKey: "RESULT_WIN")
        userdef.setObject(NSNumber(integer: loseValue), forKey: "RESULT_LOSE")
        userdef.synchronize()
        
        var resultSet = ["winner":winText, "win":String(winValue), "loss":String(loseValue)]
        self.presentControllerWithName("ResultView", context: resultSet)
    }
    
}
