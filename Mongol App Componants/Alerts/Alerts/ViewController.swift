//
//  ViewController.swift
//  Alerts
//
//  Created by MongolSuragch on 9/2/15.
//  Copyright © 2015 Suragch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let message = "This is a longer message. What happens if there is line wrap. Does the control get bigger? This is a longer message. What happens if there is line wrap. Does the control get bigger?This is a longer message. What happens if there is line wrap. Does the control get bigger? This is a longer message. What happens if there is line wrap. Does the control get bigger?This is a longer message. What happens if there is line wrap. Does the control get bigger? This is a longer message. What happens if there is line wrap. Does the control get bigger?"
    
    @IBAction func showAlert(sender: AnyObject) {
        let alertController = UIAlertController(title: "My Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let yesAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default) { (action) -> Void in
            print("The user is ok.")
        }
        let noAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Default) { (action) -> Void in
            print("The user is not ok.")
        }
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func showMongolAlert(sender: AnyObject) {
        
//        let mongolAlertViewController = MongolAlertViewController()
//        mongolAlertViewController.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
//        self.presentViewController(mongolAlertViewController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

