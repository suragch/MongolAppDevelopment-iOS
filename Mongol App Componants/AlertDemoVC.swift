//
//  AlertDemoVC.swift
//  Mongol App Componants
//
//  Created by MongolSuragch on 9/3/15.
//  Copyright © 2015 MongolSuragch. All rights reserved.
//

import UIKit

class AlertDemoVC: UIViewController, UIGestureRecognizerDelegate {

    // TODO: Make an alert that is independant of the view controller
    
    let alertView = UIView()
    let alertMessageBorder = UIView()
    let alertMessageTextView = UIMongolTextView()
    let renderer = MongolUnicodeRenderer.sharedInstance
    
    @IBAction func showAlert(sender: AnyObject) {
        
        
        let message = "1-10: ᠨᠢᠭᠡ ᠬᠤᠶᠠᠷ ᠭᠤᠷᠪᠠ ᠳᠦᠷᠪᠡ ᠲᠠᠪᠤ ᠵᠢᠷᠭᠤᠭ᠎ᠠ ᠳᠤᠯᠤᠭ᠎ᠠ ᠨᠠᠢ᠌ᠮᠠ ᠶᠢᠰᠦ ᠠᠷᠪᠠ one two three four five six seven eight nine ten"
        
        showMongolAlert(renderer.unicodeToGlyphs(message))
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loading alert demo")
        // Do any additional setup after loading the view.
        
    }
    
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        
        dismissMongolAlert()
        
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
    }
    
    
    func showMongolAlert(message: String) {
        
        print("showing alert")
        
        // constants
        let messageHeight: CGFloat = 220
        let margin: CGFloat = 20
        let cornerRadius: CGFloat = 20.0
        let fontSize: CGFloat = 17
        let backgroundAlpha: CGFloat = 0.5
        
        // make alert visible
        alertView.hidden = false
        alertMessageBorder.hidden = false
        alertMessageTextView.hidden = false
        
        // ------------------------------
        // Initialize alert on first call
        // ------------------------------
        if alertMessageBorder.subviews.count == 0 {
            
            // background
            alertView.backgroundColor = UIColor.grayColor()
            alertView.alpha = backgroundAlpha
            
            // message
            alertMessageTextView.editable = false
            alertMessageTextView.fontSize = fontSize
            
            // message border
            alertMessageBorder.backgroundColor = UIColor.whiteColor()
            alertMessageBorder.layer.cornerRadius = cornerRadius
            
            // Gesture recognizer to dismiss view
            let tapGesture = UITapGestureRecognizer(target: self, action: "dismissMongolAlert")
            tapGesture.delegate = self
            alertView.addGestureRecognizer(tapGesture)
            
            // Add subviews
            self.view.addSubview(alertView)
            self.view.addSubview(alertMessageBorder)
            alertMessageBorder.addSubview(alertMessageTextView)
        }
        
        // ----------------
        // Resize the alert
        // ----------------
        
        // background
        alertView.frame = view.bounds
        
        // message
        alertMessageTextView.text = message
        let textViewSize = alertMessageTextView.sizeThatFits(CGSize(width: CGFloat.max, height: messageHeight))
        // adjust view width, or scroll if wider than screen width
        if textViewSize.width + 2 * margin < self.view.bounds.width {
            alertMessageTextView.frame = CGRect(x: margin, y: margin, width: textViewSize.width, height: textViewSize.height)
            alertMessageTextView.scrollEnabled = false
        } else { // scroll
            alertMessageTextView.frame = CGRect(x: margin, y: margin, width: self.view.bounds.width - 2 * margin, height: textViewSize.height)
            alertMessageTextView.scrollEnabled = true
        }
        
        // message border
        alertMessageBorder.frame = CGRect(x: 0, y: 0, width: alertMessageTextView.frame.width + 2 * margin, height: alertMessageTextView.frame.height + 2 * margin)
        alertMessageBorder.center = self.view.center
    }
    
    func dismissMongolAlert() {
        print("dismissing alert")
        alertView.hidden = true
        alertMessageBorder.hidden = true
        alertMessageTextView.hidden = true
    }

}
