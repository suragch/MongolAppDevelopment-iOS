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

    
    @IBAction func showMongolAlertButtonTapped(sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myAlert = storyboard.instantiateViewControllerWithIdentifier("MongolAlertControllerID")
        myAlert.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        myAlert.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        self.presentViewController(myAlert, animated: true, completion: nil)
    }

    @IBAction func showStandardAlertButtonTapped(sender: UIButton) {
        
        // create the alert
        let alert = UIAlertController(title: "My Title", message: "This is my message.", preferredStyle: UIAlertControllerStyle.Alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        // show the alert
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func alert2button(sender: UIButton) {
        
        showAlert(withTitle: "Hello", message: "This is my message", topButtonText: "OK", bottomButtonText: "Cancel")
    }
    
    func showAlert(withTitle title: String?, message: String?, topButtonText: String?, bottomButtonText: String?) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myAlertController = storyboard.instantiateViewControllerWithIdentifier("MongolAlertController2ID") as! UIMongolAlertController2
        myAlertController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        myAlertController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        
        myAlertController.titleText = title
        myAlertController.messageText = message
        myAlertController.buttonOneText = topButtonText
        myAlertController.buttonTwoText = bottomButtonText
        myAlertController.buttonOneAction = {
            () -> Void in
            print("botton one works")
        }
        myAlertController.buttonTwoAction = {
            () -> Void in
            print("button two works")
        }
        
        self.presentViewController(myAlertController, animated: true, completion: nil)
    }
}
