
import UIKit

protocol KeyboardKeyDelegate {
    func keyTextEntered(keyText: String)
}

@IBDesignable
class KeyboardKey: UIControl {
    
    var delegate: KeyboardKeyDelegate?
    //var timer = NSTimer()
    //let longPressTimeThreshold = 1.0 // seconds
    private let backgroundLayer = KeyboardKeyBackgroundLayer()
    
    // MARK: Primary input value
    
    private let primaryLabel = UIMongolLabel()
    
    @IBInspectable var primaryLetter: String = "A" {
        didSet {
            primaryLabel.text = primaryLetter
        }
    }
    // use if display form should be different than primaryLetter
    var primaryLetterDisplayOverride = "A" {
        didSet {
            primaryLabel.text = primaryLetterDisplayOverride
        }
    }
    @IBInspectable var primaryLetterFontSize: CGFloat = 17 {
        didSet {
            primaryLabel.fontSize = primaryLetterFontSize
        }
    }
    
    // MARK: Secondary (long press) input value
    
    private let secondaryLabel = UIMongolLabel()
    
    @IBInspectable var secondaryLetter: String = "B" {
        didSet {
            secondaryLabel.text = secondaryLetter
        }
    }
    // use if display form should be different than secondaryLetter
    var secondaryLetterDisplayOverride = "B" {
        didSet {
            secondaryLabel.text = secondaryLetterDisplayOverride
        }
    }
    @IBInspectable var secondaryLetterFontSize: CGFloat = 12 {
        didSet {
            secondaryLabel.fontSize = secondaryLetterFontSize
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
    //var curvaceousness: CGFloat = 0.2

    
    
    
    
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
            updateLayerFrames()
        }
    }
    
    func setup() {
        
        // Background layer
        backgroundLayer.keyboardKey = self
        backgroundLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(backgroundLayer)
        
        // Primary letter
        primaryLabel.text = primaryLetter
        primaryLabel.textAlignment = NSTextAlignment.Center
        primaryLabel.userInteractionEnabled = false
        self.addSubview(primaryLabel)
        
        // Secondary letter
        secondaryLabel.text = secondaryLetter
        secondaryLabel.textAlignment = NSTextAlignment.Center
        secondaryLabel.userInteractionEnabled = false
        secondaryLabel.textColor = UIColor.grayColor()
        self.addSubview(secondaryLabel)
        
        // Long press guesture recognizer
        let longPress = UILongPressGestureRecognizer(target: self, action: "longPress:")
        self.addGestureRecognizer(longPress)
    }
    
    func updateLayerFrames() {
        
        backgroundLayer.frame = bounds
        backgroundLayer.setNeedsDisplay()
        
        primaryLabel.frame = bounds
        //primaryLabel.setNeedsDisplay() // TODO this may not be needed for a label
        
        let sideLength = bounds.width / 3
        let margin = bounds.width / 10
        secondaryLabel.frame = CGRect(x: bounds.width - sideLength - margin, y: bounds.height - sideLength - margin, width: sideLength, height: sideLength)
        //secondaryLabel.setNeedsDisplay()
        
    }
    
    // MARK: - Other methods
    
//    func longPress() {
//        
//        print("Long Press")
//        //inputValue = secondaryLetter
//        backgroundLayer.highlighted = false
//        
//    }
    
    func longPress(guesture: UILongPressGestureRecognizer) {
        if guesture.state == UIGestureRecognizerState.Began {
            print("Long Press")
            //inputValue = secondaryLetter
            delegate?.keyTextEntered(self.secondaryLetter)
            backgroundLayer.highlighted = false
        }
    }
    
    // MARK: - Overrides
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        
        //inputValue = primaryLetter
        backgroundLayer.highlighted = true
        
        // begin timing for long press input event
        //timer = NSTimer.scheduledTimerWithTimeInterval(longPressTimeThreshold, target: self, selector: "longPress", userInfo: nil, repeats: false)
        
        return backgroundLayer.highlighted
    }
    
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        
        delegate?.keyTextEntered(self.primaryLetter)
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
    
    override func drawInContext(ctx: CGContext) {
        if let key = keyboardKey {
            
            let keyFrame = bounds.insetBy(dx: 2.0, dy: 2.0)
            //let cornerRadius = keyFrame.height * thisKey.curvaceousness / 2.0
            let keyPath = UIBezierPath(roundedRect: keyFrame, cornerRadius: key.cornerRadius)
            
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
}

