// This is a generic Keyboard Key class for specific key classes to subclass. Its main purposes are to 
// (1) provide a common background appearance for all keys
// (2) set the standard for how to communicate with the parent keyboard class


import UIKit

// protocol for communication with keyboard
protocol KeyboardKeyDelegate: class {
    func keyTextEntered(keyText: String)
    func keyBackspaceTapped()
}


@IBDesignable
class KeyboardKey: UIControl {
    
    weak var delegate: KeyboardKeyDelegate? // probably a keyboard class
    
    private let backgroundLayer = KeyboardKeyBackgroundLayer()
    
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
        initializeBackgroundLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeBackgroundLayer()
    }
    
    override var frame: CGRect {
        didSet {
            updateBackgroundFrame()
        }
    }
    
    func initializeBackgroundLayer() {
        
        // Background layer
        backgroundLayer.keyboardKey = self
        backgroundLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(backgroundLayer)
        
        
        // Long press guesture recognizer
        addLongPressGestureRecognizer()
    }
    
    // subclasses can override this method if they don't want the gesture recognizer
    func addLongPressGestureRecognizer() {
        
            let longPress = UILongPressGestureRecognizer(target: self, action: "longPress:")
            self.addGestureRecognizer(longPress)
        
    }
    
    func updateBackgroundFrame() {
        
        backgroundLayer.frame = bounds
        backgroundLayer.setNeedsDisplay()
        
    }
    
    // MARK: - Other methods
    
    func longPress(guesture: UILongPressGestureRecognizer) {
        if guesture.state == UIGestureRecognizerState.Began {
            
            backgroundLayer.highlighted = false
            longPressBegun()
            
        } else if guesture.state == UIGestureRecognizerState.Changed {
            
            longPressStateChanged(guesture)
        } else if guesture.state == UIGestureRecognizerState.Ended {
            longPressEnded()
        }
    }
    
    func longPressBegun() {
        // this method is for subclasses to override
    }
    
    func longPressStateChanged(guesture: UILongPressGestureRecognizer) {
        // this method is for subclasses to override
    }
    
    func longPressEnded() {
        // this method is for subclasses to override
    }
    
    // MARK: - Overrides
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        
        backgroundLayer.highlighted = true
        return backgroundLayer.highlighted
    }
    
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        
        backgroundLayer.highlighted = false
    }
    
}

// MARK: - Key Background Layer Class

class KeyboardKeyBackgroundLayer: CALayer {
    var highlighted: Bool = false {
        didSet {
            setNeedsDisplay()
        }
    }
    weak var keyboardKey: KeyboardKey?
    let padding: CGFloat = 2.0
    
    override func drawInContext(ctx: CGContext) {
        if let key = keyboardKey {
            
            let keyFrame = bounds.insetBy(dx: padding, dy: padding)
            let keyPath = UIBezierPath(roundedRect: keyFrame, cornerRadius: key.cornerRadius)
            
            // Shadow
            let shadowColor = UIColor.grayColor()
            CGContextSetShadowWithColor(ctx, CGSize(width: 0.0, height: 1.0), 1.0, shadowColor.CGColor)
            
            // Fill
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
}


