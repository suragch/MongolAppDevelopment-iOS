//
//  ButtonDemoVC.swift
//  Mongol App Componants
//
//  Created by MongolSuragch on 9/12/15.
//  Copyright © 2015 MongolSuragch. All rights reserved.
//

import UIKit

class ButtonDemoVC: UIViewController {

    
    
    
    
    
    @IBAction func mongolButton(sender: AnyObject) {
        
        print("UIMongolButton tapped")
    }
    @IBAction func myActionObject(sender: AnyObject) {
        print("UIButton tapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let myButton = UIButton()
//        myButton.setTitle("This is a title", forState: UIControlState.Normal)
//        myButton.setTitleColor(UIColor.blueColor(), forState: .Normal)
//        myButton.frame = CGRect(x: 15, y: 15, width: 300, height: 500)
//        myButton.addTarget(self, action: "pressedAction:", forControlEvents: UIControlEvents.TouchUpInside)
//        self.view.addSubview(myButton)
        
    }
    
    func pressedAction(sender: UIButton!) {
        print("my button was clicked")
    }

    
}
