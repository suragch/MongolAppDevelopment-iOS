//
//  AlertControllerDemoVC.swift
//  Mongol App Componants
//
//  Created by MongolSuragch on 5/18/16.
//  Copyright © 2016 MongolSuragch. All rights reserved.
//

import UIKit

class AlertControllerDemoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func showButtonlessAlertTapped(sender: UIButton) {
        let title = "ᠳᠤᠰ ᠪᠢᠴᠢᠯᠭᠡ ᠬᠠᠭᠤᠯᠠᠭᠳᠠᠪᠠ"
        let message = "ᠳᠤᠰ ᠪᠢᠴᠢᠯᠭᠡ ᠶᠢᠨ ᠶᠦᠨᠢᠺᠤᠳ᠋ ᠲᠡᠺᠧᠰᠲ ᠢ ᠭᠠᠷ ᠤᠳᠠᠰᠤᠨ ᠰᠢᠰᠲ᠋ᠧᠮ ᠦᠨ ᠨᠠᠭᠠᠬᠤ ᠰᠠᠮᠪᠠᠷ᠎ᠠ ᠳᠤ ᠬᠠᠭᠤᠯᠠᠭᠳᠠᠪᠠ᠃ ᠳᠠ ᠡᠭᠦᠨ ᠢ ᠪᠤᠰᠤᠳ APP ᠳᠤ ᠨᠠᠭᠠᠵᠤ ᠬᠡᠷᠡᠭᠯᠡᠵᠤ ᠪᠤᠯᠤᠨ᠎ᠠ᠃ ᠭᠡᠪᠡᠴᠦ ᠮᠤᠩᠭᠤᠯ ᠬᠡᠯᠡᠨ ᠦ ᠶᠦᠨᠢᠺᠤᠳ᠋ ᠤᠨ ᠪᠠᠷᠢᠮᠵᠢᠶ᠎ᠠ ᠨᠢᠭᠡᠳᠦᠭᠡᠳᠦᠢ ᠳᠤᠯᠠ ᠵᠠᠷᠢᠮ ᠰᠤᠹᠲ ᠪᠤᠷᠤᠭᠤ ᠦᠰᠦᠭ ᠢᠶᠡᠷ ᠢᠯᠡᠷᠡᠬᠦ ᠮᠠᠭᠠᠳ᠃ "
        showZeroButtonAlert(withTitle: title, message: message, alertWidth: 250)
    }
    @IBAction func showOneButtonAlertTapped(sender: UIButton) {
        
        let title = "ᠳᠤᠰ ᠪᠢᠴᠢᠯᠭᠡ ᠬᠠᠭᠤᠯᠠᠭᠳᠠᠪᠠ"
        let message = "ᠳᠤᠰ ᠪᠢᠴᠢᠯᠭᠡ ᠶᠢᠨ ᠶᠦᠨᠢᠺᠤᠳ᠋ ᠲᠡᠺᠧᠰᠲ ᠢ ᠭᠠᠷ ᠤᠳᠠᠰᠤᠨ ᠰᠢᠰᠲ᠋ᠧᠮ ᠦᠨ ᠨᠠᠭᠠᠬᠤ ᠰᠠᠮᠪᠠᠷ᠎ᠠ ᠳᠤ ᠬᠠᠭᠤᠯᠠᠭᠳᠠᠪᠠ᠃ ᠳᠠ ᠡᠭᠦᠨ ᠢ ᠪᠤᠰᠤᠳ APP ᠳᠤ ᠨᠠᠭᠠᠵᠤ ᠬᠡᠷᠡᠭᠯᠡᠵᠤ ᠪᠤᠯᠤᠨ᠎ᠠ᠃ ᠭᠡᠪᠡᠴᠦ ᠮᠤᠩᠭᠤᠯ ᠬᠡᠯᠡᠨ ᠦ ᠶᠦᠨᠢᠺᠤᠳ᠋ ᠤᠨ ᠪᠠᠷᠢᠮᠵᠢᠶ᠎ᠠ ᠨᠢᠭᠡᠳᠦᠭᠡᠳᠦᠢ ᠳᠤᠯᠠ ᠵᠠᠷᠢᠮ ᠰᠤᠹᠲ ᠪᠤᠷᠤᠭᠤ ᠦᠰᠦᠭ ᠢᠶᠡᠷ ᠢᠯᠡᠷᠡᠬᠦ ᠮᠠᠭᠠᠳ᠃ "
        let action = {
            () -> Void in
            print("button works")
        }
        showOneButtonAlert(withTitle: title, message: message, topButtonText: "ᠮᠡᠳᠡᠯ᠎ᠡ", action: action, alertWidth: 300)
    }
    @IBAction func showTwoButtonAlertTapped(sender: UIButton) {
        
        let title = "ᠤᠰᠠᠳᠬᠠᠬᠤ"
        let message = "ᠲᠠ ᠦᠨᠡᠭᠡᠷ ᠪᠦᠬᠦ ᠵᠠᠬᠢᠵ᠎ᠠ ᠶᠢ ᠤᠰᠠᠳᠬᠠᠬᠤ ᠤᠤ?"
        
        let actionOne = {
            () -> Void in
            print("top button works")
        }
        let actionTwo = {
            () -> Void in
            print("bottom button works")
        }
        
        showAlert(withTitle: title, message: message, numberOfButtons: 2, topButtonText: "ᠲᠡᠭᠡ", topButtonAction: actionOne, bottomButtonText: "ᠪᠤᠯᠢ", bottomButtonAction: actionTwo, alertWidth: 170)
    }


    @IBAction func showStandardAlertButtonTapped(sender: UIButton) {
        
        // create the alert
        let alert = UIAlertController(title: "My Title", message: "This is my message.", preferredStyle: UIAlertControllerStyle.Alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
    

    func showZeroButtonAlert(withTitle title: String?, message: String?, alertWidth: CGFloat?) {
        
        //showAlert(withTitle: title, message: message, numberOfButtons: 0, topButtonText: nil, bottomButtonText: nil, alertWidth: alertSize)
        showAlert(withTitle: title, message: message, numberOfButtons: 0, topButtonText: nil, topButtonAction: nil, bottomButtonText: nil, bottomButtonAction: nil, alertWidth: 170)

    }
    
    func showOneButtonAlert(withTitle title: String?, message: String?, topButtonText: String?, action: (()->Void)?, alertWidth: CGFloat?){
        
        //showAlert(withTitle: title, message: message, numberOfButtons: 1, topButtonText: topButtonText, bottomButtonText: nil, alertWidth: alertSize)
        showAlert(withTitle: title, message: message, numberOfButtons: 1, topButtonText: topButtonText, topButtonAction: action, bottomButtonText: nil, bottomButtonAction: nil, alertWidth: alertWidth)

    }
    
    
    
}
