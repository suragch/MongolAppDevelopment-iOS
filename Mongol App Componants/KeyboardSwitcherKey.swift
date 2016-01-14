//
//  KeyboardSwitcherKey.swift
//  Mongol App Componants
//
//  Created by MongolSuragch on 1/8/16.
//  Copyright © 2016 MongolSuragch. All rights reserved.
//

import UIKit

class KeyboardSwitcherKey: UIControl {

    // TODO: It would be better to subclass this Key
    
    weak var delegate: KeyboardKeyDelegate? // probably a keyboard class
    
    private let backgroundLayer = KeyboardSwitcherKeyBackgroundLayer()
    
    private let imageLayer = CALayer()
    
    var primaryString: String = ""
    var secondaryString: String = ""
    
    // popup keyboard menu
    var popupHeight: CGFloat = 80
    var numberOfItems = 3
    var itemWidth: CGFloat = 40
    
    
    @IBInspectable var image: UIImage?
        {
        didSet {
            imageLayer.contents = image?.CGImage
            updateImageLayerFrame()
        }
    }
    
    var padding: CGFloat {
        get {
            return backgroundLayer.padding
        }
    }
    
    
    // MARK: Other properties
    var fillTintColor = UIColor.whiteColor() {
        didSet {
            backgroundLayer.setNeedsDisplay()
        }
    }
    @IBInspectable var cornerRadius: CGFloat = 8 {
        didSet {
            backgroundLayer.setNeedsDisplay()
        }
    }
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    override var frame: CGRect {
        didSet {
            updateBackgroundFrame()
            updateImageLayerFrame()
        }
    }
    
    func setup() {
        
        // Background layer
        backgroundLayer.keyboardKey = self
        backgroundLayer.contentsScale = UIScreen.mainScreen().scale
        //backgroundLayer.zPosition = 1
        layer.addSublayer(backgroundLayer)
        
        // image layer
        imageLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(imageLayer)

        
        // Long press guesture recognizer
        let longPress = UILongPressGestureRecognizer(target: self, action: "longPress:")
        self.addGestureRecognizer(longPress)
    }
    
    func updateImageLayerFrame() {
        
        if let unwrappedImage = image {
            imageLayer.frame = bounds
            
            // shrink image if larger than bounds
            if unwrappedImage.size.height > bounds.height || unwrappedImage.size.width > bounds.width {
                imageLayer.contentsGravity = kCAGravityResizeAspect
            } else {
                imageLayer.contentsGravity = kCAGravityCenter
            }
            
        }
        
    }
    
    func updateBackgroundFrame() {
        
        backgroundLayer.frame = bounds
        backgroundLayer.setNeedsDisplay()
        
    }
    
    // MARK: - Other methods
    
    func longPress(guesture: UILongPressGestureRecognizer) {
        if guesture.state == UIGestureRecognizerState.Began {
            
            backgroundLayer.highlighted = false
            
            if self.secondaryString != "" {
                delegate?.keyTextEntered(self.secondaryString)
            } else {
                // enter primary string if this key has no seconary string
                delegate?.keyTextEntered(self.primaryString)
            }
        }
    }
    
    
    
    // MARK: - Overrides
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        
        backgroundLayer.highlighted = true
        return backgroundLayer.highlighted
    }
    
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        
        // TODO: Set background layer highlighting flags
        
        
         return true
    }
    
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        
        backgroundLayer.highlighted = false
    }
    
    
    
}

class KeyboardSwitcherKeyBackgroundLayer: CALayer {
    var highlighted: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    var longpressed: Bool = true {
        didSet {
            setNeedsDisplay()
        }
    }
    weak var keyboardKey: KeyboardSwitcherKey?
    let padding: CGFloat = 2.0
    
    override func drawInContext(ctx: CGContext) {
        if let key = keyboardKey {
            
            let keyFrame = bounds.insetBy(dx: padding, dy: padding)
            var keyPath: UIBezierPath!
            
            if longpressed {
                
                // TODO: make the popup menu
                keyPath = popupMenuPath(key)
                
                // get some results from continueTrackingWithTouch
            } else {
                
                // TODO: hide the popup menu
                
                keyPath = UIBezierPath(roundedRect: keyFrame, cornerRadius: key.cornerRadius)
            }
            
            
            
            
            
            
            
            
            
            // Shadow
            let shadowColor = UIColor.grayColor()
            CGContextSetShadowWithColor(ctx, CGSize(width: 0.0, height: 1.0), 1.0, shadowColor.CGColor)
            CGContextSetFillColorWithColor(ctx, key.fillTintColor.CGColor)
            CGContextAddPath(ctx, keyPath.CGPath)
            CGContextFillPath(ctx)
            
            // Outline
            CGContextSetStrokeColorWithColor(ctx, shadowColor.CGColor)
            CGContextSetLineWidth(ctx, 0.5)
            CGContextAddPath(ctx, keyPath.CGPath)
            CGContextStrokePath(ctx)
            
            if highlighted {
                CGContextSetFillColorWithColor(ctx, UIColor(white: 0.0, alpha: 0.1).CGColor)
                CGContextAddPath(ctx, keyPath.CGPath)
                CGContextFillPath(ctx)
            }
            
        }
    }
    
    func popupMenuPath(key: KeyboardSwitcherKey) -> UIBezierPath {
        
        //  ------------------
        // |                  |
        // |                  |
        // |                  |
        // |                  |
        // |                  |
        // |                  |
        // *     -------------
        // |    |
        // |    |
        //  ----
        // 
        // * starting point close to (0,0)
        // working clockwise
    
        // create a new path
        let path = UIBezierPath()
        
        // stop now if key is nil
        if keyboardKey == nil {
            return path
        }
        
        // starting point for the path (on left side)
        path.moveToPoint(CGPoint(x: padding, y: 0))
        
        // top-left corner
        path.addArcWithCenter(
            CGPoint(
                x: padding + key.cornerRadius,
                y: -key.popupHeight + padding + key.cornerRadius),
            radius: key.cornerRadius,
            startAngle: CGFloat(M_PI), // straight left
            endAngle: CGFloat(3*M_PI_2), // straight up
            clockwise: true)
        
        // top-right corner
        path.addArcWithCenter(
            CGPoint(
                x: padding + CGFloat(key.numberOfItems) * key.itemWidth - key.cornerRadius,
                y: -key.popupHeight + padding + key.cornerRadius),
            radius: key.cornerRadius,
            startAngle: CGFloat(3*M_PI_2), // straight up
            endAngle: CGFloat(0), // straight right
            clockwise: true)
        
        // mid-right corner
        path.addArcWithCenter(
            CGPoint(
                x: padding + CGFloat(key.numberOfItems) * key.itemWidth - key.cornerRadius,
                y: -padding - key.cornerRadius),
            radius: key.cornerRadius,
            startAngle: CGFloat(0), // straight right
            endAngle: CGFloat(M_PI_2), // straight down
            clockwise: true)
        
        // mid-bottom upper corner
        path.addArcWithCenter(
            CGPoint(
                x: bounds.width - padding + key.cornerRadius,
                y: -padding - key.cornerRadius),
            radius: key.cornerRadius,
            startAngle: CGFloat(3*M_PI_2), // straight up
            endAngle: CGFloat(M_PI), // straight left
            clockwise: false)
        
        // mid-bottom lower corner
        path.addArcWithCenter(
            CGPoint(
                x: bounds.width - padding - key.cornerRadius,
                y: bounds.height - padding - key.cornerRadius),
            radius: key.cornerRadius,
            startAngle: CGFloat(0), // straight right
            endAngle: CGFloat(M_PI_2), // straight down
            clockwise: true)
        
        // bottom-left corner
        path.addArcWithCenter(
            CGPoint(
                x: padding + key.cornerRadius,
                y: bounds.height - padding - key.cornerRadius),
            radius: key.cornerRadius,
            startAngle: CGFloat(M_PI_2), // straight down
            endAngle: CGFloat(M_PI), // straight left
            clockwise: true)

        
        path.closePath() // draws the final line to close the path
        
        return path
    }
}

