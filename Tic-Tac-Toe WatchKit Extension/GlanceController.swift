//
//  GlanceController.swift
//  Tic-Tac-Toe
//
//  Created by George Shamugia on 08/12/2014.
//  Copyright (c) 2014 George Shamugia. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {
    
    @IBOutlet weak var winLabel:WKInterfaceLabel!
    @IBOutlet weak var lossLabel:WKInterfaceLabel!
    
    override func willActivate() {
        super.willActivate()
        
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
        
        winLabel.setText("Win: \(winValue)")
        lossLabel.setText("Loss: \(loseValue)")
    }
    
    override func didDeactivate() {
        NSLog("%@ did deactivate", self)
        super.didDeactivate()
    }
    
}
