//
//  MongolAlertController2.swift
//  Mongol App Componants
//
//  Created by MongolSuragch on 6/18/16.
//  Copyright © 2016 MongolSuragch. All rights reserved.
//

import UIKit

class UIMongolAlertController2: UIViewController, UIGestureRecognizerDelegate  {
    
    // TODO: Create this view controller entirely programmatically
    @IBOutlet weak var alertTitle: UIMongolLabel!
    @IBOutlet weak var alertMessage: UIMongolLabel!
    @IBOutlet weak var alertContainerView: UIView!
    @IBOutlet weak var topButton: UIMongolLabel!
    @IBOutlet weak var bottomButton: UIMongolLabel!
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    var titleText: String?
    var messageText: String?
    var numberOfButtons = 1
    var buttonOneText: String?
    var buttonTwoText: String?
    var buttonOneAction: (()->Void)?
    var buttonTwoAction: (()->Void)?
    
    let renderer = MongolUnicodeRenderer.sharedInstance
    private let buttonTapHighlightColor = UIColor.lightGrayColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        widthConstraint.constant = 200
        
        
        
        if let unwrappedTitle = titleText {
            alertTitle.text = renderer.unicodeToGlyphs(unwrappedTitle)
        }
        if let unwrappedMessage = messageText {
            alertMessage.text = renderer.unicodeToGlyphs(unwrappedMessage)
        }
        if let buttonOneText = buttonOneText {
            topButton.text = renderer.unicodeToGlyphs(buttonOneText)
        }
        if let buttonTwoText = buttonTwoText {
            bottomButton.text = renderer.unicodeToGlyphs(buttonTwoText)
        }
        
        
        alertContainerView.layer.cornerRadius = 13
        alertContainerView.clipsToBounds = true
        
        // Gesture recognizers
        
        let tapOne = UILongPressGestureRecognizer(target: self, action: #selector(buttonOneHandler))
        tapOne.minimumPressDuration = 0
        topButton.addGestureRecognizer(tapOne)
        
        let tapTwo = UILongPressGestureRecognizer(target: self, action: #selector(buttonTwoHandler))
        tapTwo.minimumPressDuration = 0
        bottomButton.addGestureRecognizer(tapTwo)
        
    }
    
    func buttonOneHandler(gesture: UITapGestureRecognizer) {
        
        
        if gesture.state == .Began{
            topButton.backgroundColor = buttonTapHighlightColor
        } else if gesture.state == UIGestureRecognizerState.Changed {
            
            // cancel gesture
            gesture.enabled = false
            gesture.enabled = true
            topButton.backgroundColor = UIColor.clearColor()
            
        } else if  gesture.state == .Ended {
            topButton.backgroundColor = UIColor.clearColor()
            if let action = self.buttonOneAction {
                action()
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func buttonTwoHandler(gesture: UITapGestureRecognizer) {
        
        if gesture.state == .Began {
            bottomButton.backgroundColor = buttonTapHighlightColor
        } else if gesture.state == UIGestureRecognizerState.Changed {
            
            // cancel gesture
            gesture.enabled = false
            gesture.enabled = true
            bottomButton.backgroundColor = UIColor.clearColor()
            
        } else if  gesture.state == .Ended {
            bottomButton.backgroundColor = UIColor.clearColor()
            if let action = self.buttonTwoAction {
                action()
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        
        
    }
    
    func changeColor(gesture: UITapGestureRecognizer) {
        
    }
}
