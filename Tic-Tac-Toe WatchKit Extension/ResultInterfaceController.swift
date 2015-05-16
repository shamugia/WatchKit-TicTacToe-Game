//
//  ResultInterfaceController.swift
//  Tic-Tac-Toe
//
//  Created by George Shamugia on 26/11/2014.
//  Copyright (c) 2014 George Shamugia. All rights reserved.
//

import WatchKit
import Foundation

class ResultInterfaceController: WKInterfaceController {
 
    @IBOutlet weak var background:WKInterfaceGroup!
    @IBOutlet weak var resultLabel:WKInterfaceLabel!
    @IBOutlet weak var winStatsLabel:WKInterfaceLabel!
    @IBOutlet weak var lossStatsLabel:WKInterfaceLabel!
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        if WKInterfaceDevice.currentDevice().screenBounds.size.width > 136  //42mm
        {
            background.setBackgroundImageNamed("42_boardbg")
        }
        else
        {
            background.setBackgroundImageNamed("38_boardbg")
        }
        
        if let displayData:[String:String] = context as? Dictionary
        {
            resultLabel.setText(displayData["winner"])
            var win = displayData["win"]
            var loss = displayData["loss"]
            winStatsLabel.setText("Win: \(win!)")
            lossStatsLabel.setText("Loss: \(loss!)")
        }
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
}
