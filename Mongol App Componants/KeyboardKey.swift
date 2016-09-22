// This is a generic Keyboard Key class for specific key classes to subclass. Its main purposes are to
// (1) provide a common background appearance for all keys
// (2) set the standard for how to communicate with the parent keyboard class


import UIKit

// protocol for communication with keyboard
protocol KeyboardKeyDelegate: class {
    func keyTextEntered(_ keyText: String)
    func keyFvsTapped(_ fvs: String)
    func keyBackspaceTapped()
    func keyKeyboardTapped()
    func keyNewKeyboardChosen(_ keyboardName: String)
    func otherAvailableKeyboards(_ displayNames: [String])
}


@IBDesignable
class KeyboardKey: UIControl {
    
    weak var delegate: KeyboardKeyDelegate? // probably a keyboard class
    
    fileprivate let backgroundLayer = KeyboardKeyBackgroundLayer()
    fileprivate var oldFrame = CGRect.zero
    
    // space between the frame edge of the visible border of the key
    var padding: CGFloat {
        get {
            return backgroundLayer.padding
        }
    }

    var fillColor = UIColor.white {
        didSet {
            backgroundLayer.setNeedsDisplay()
        }
    }
    
    var borderColor = UIColor.gray {
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
            // only update frames if non-zero and changed
            if frame != CGRect.zero && frame != oldFrame {
                updateBackgroundFrame()
            }
        }
    }
    
    func initializeBackgroundLayer() {
        
        // Background layer
        backgroundLayer.keyboardKey = self
        backgroundLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(backgroundLayer)
        
        
        // Long press guesture recognizer
        addLongPressGestureRecognizer()
    }
    
    // subclasses can override this method if they don't want the gesture recognizer
    func addLongPressGestureRecognizer() {
        
            let longPress = UILongPressGestureRecognizer(target: self, action: #selector(longPress(_:)))
            self.addGestureRecognizer(longPress)
        
    }
    
    func updateBackgroundFrame() {
        
        backgroundLayer.frame = bounds
        backgroundLayer.setNeedsDisplay()
        
    }
    
    // MARK: - Other methods
    
    func longPress(_ guesture: UILongPressGestureRecognizer) {
        if guesture.state == UIGestureRecognizerState.began {
            
            backgroundLayer.highlighted = false
            longPressBegun(guesture)
            
        } else if guesture.state == UIGestureRecognizerState.changed {
            
            longPressStateChanged(guesture)
        } else if guesture.state == UIGestureRecognizerState.ended {
            longPressEnded()
        } else if guesture.state == UIGestureRecognizerState.cancelled {
            longPressCancelled()
        }
    }
    
    func longPressBegun(_ guesture: UILongPressGestureRecognizer) {
        // this method is for subclasses to override
    }
    
    func longPressStateChanged(_ guesture: UILongPressGestureRecognizer) {
        // this method is for subclasses to override
    }
    
    func longPressEnded() {
        // this method is for subclasses to override
    }
    
    func longPressCancelled() {
        // this method is for subclasses to override
    }
    
    // MARK: - Overrides
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        backgroundLayer.highlighted = true
        return backgroundLayer.highlighted
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        
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
    
    override func draw(in ctx: CGContext) {
        if let key = keyboardKey {
            
            let keyFrame = bounds.insetBy(dx: padding, dy: padding)
            let keyPath = UIBezierPath(roundedRect: keyFrame, cornerRadius: key.cornerRadius)
            //let borderColor = key.borderColor.CGColor
            
            // Fill
            ctx.setFillColor(key.fillColor.cgColor)
            ctx.addPath(keyPath.cgPath)
            ctx.fillPath()
            
            // Outline
            ctx.setStrokeColor(key.borderColor.cgColor)
            ctx.setLineWidth(0.5)
            ctx.addPath(keyPath.cgPath)
            ctx.strokePath()
            
            if highlighted {
                ctx.setFillColor(UIColor(white: 0.0, alpha: 0.1).cgColor)
                ctx.addPath(keyPath.cgPath)
                ctx.fillPath()
            }
            
        }
    }
}


