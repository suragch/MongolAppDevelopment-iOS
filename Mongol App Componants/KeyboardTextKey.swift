// This keyboard key has two text string locations for vertical Mongolian script, one centered and one in the bottom right.


import UIKit

@IBDesignable
class KeyboardTextKey: KeyboardKey {
    
    //private let imageLayer = CALayer()
    private let primaryLayer = KeyboardKeyTextLayer()
    private let secondaryLayer = KeyboardKeyTextLayer()
    let secondaryLayerMargin: CGFloat = 10.0
    let mongolFontName = "ChimeeWhiteMirrored"
    var useMirroredFont = true
    private var oldFrame = CGRectZero
    
    // MARK: Primary input value
    
    @IBInspectable var primaryString: String = "A" {
        didSet {
            primaryLayer.displayString = primaryString
            updatePrimaryLayerFrame()
        }
    }
    // use if display form should be different than primaryLetter
    var primaryStringDisplayOverride = "" {
        didSet {
            primaryLayer.displayString = primaryStringDisplayOverride
            updatePrimaryLayerFrame()
        }
    }
    @IBInspectable var primaryStringFontSize: CGFloat = 17 {
        didSet {
            updatePrimaryLayerFrame()
        }
    }
    
    // MARK: Secondary (long press) input value
    
    @IBInspectable var secondaryString: String = "" {
        didSet {
            secondaryLayer.displayString = secondaryString
            updateSecondaryLayerFrame()
        }
    }
    // use if display form should be different than secondaryLetter
    var secondaryStringDisplayOverride = "" {
        didSet {
            secondaryLayer.displayString = secondaryStringDisplayOverride
            updateSecondaryLayerFrame()
        }
    }
    @IBInspectable var secondaryStringFontSize: CGFloat = 12 {
        didSet {
            updateSecondaryLayerFrame()
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
            
            // only update frames if non-zero and changed
            if frame != CGRectZero && frame != oldFrame {
                updatePrimaryLayerFrame()
                updateSecondaryLayerFrame()
                oldFrame = frame
            }
            
            
        }
    }
    
    func setup() {
        
        
        // Primary text layer
        primaryLayer.useMirroredFont = useMirroredFont
        primaryLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(primaryLayer)
        
        // Secondary text layer
        secondaryLayer.useMirroredFont = useMirroredFont
        secondaryLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(secondaryLayer)
        
        
    }
    
    func updatePrimaryLayerFrame() {
        
        let myAttribute = [ NSFontAttributeName: UIFont(name: mongolFontName, size: primaryStringFontSize )! ]
        let attrString = NSMutableAttributedString(string: primaryLayer.displayString, attributes: myAttribute )
        let size = dimensionsForAttributedString(attrString)
        
        // This is the frame for the soon-to-be rotated layer
        let x = (layer.bounds.width - size.height) / 2
        let y = (layer.bounds.height - size.width) / 2
        primaryLayer.frame = CGRect(x: x, y: y, width: size.height, height: size.width)
        primaryLayer.string = attrString
    }
    
    func updateSecondaryLayerFrame() {
        let myAttribute = [ NSFontAttributeName: UIFont(name: mongolFontName, size: secondaryStringFontSize )! ]
        let attrString = NSMutableAttributedString(string: secondaryLayer.displayString, attributes: myAttribute )
        let size = dimensionsForAttributedString(attrString)
        
        // This is the frame for the soon-to-be rotated layer
        let x = layer.bounds.width - size.height - secondaryLayerMargin
        let y = layer.bounds.height - size.width - secondaryLayerMargin
        secondaryLayer.frame = CGRect(x: x, y: y, width: size.height, height: size.width)
        secondaryLayer.string = attrString
    }
    
    
    override func longPressBegun(guesture: UILongPressGestureRecognizer) {
        if self.secondaryString != "" {
            delegate?.keyTextEntered(self.secondaryString)
        } else {
            // enter primary string if this key has no seconary string
            delegate?.keyTextEntered(self.primaryString)
        }
    }
    
    // tap event (do when finger lifted)
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        super.endTrackingWithTouch(touch, withEvent: event)
        
        delegate?.keyTextEntered(self.primaryString)
        
    }
    
    func dimensionsForAttributedString(attrString: NSAttributedString) -> CGSize {
        
        var ascent: CGFloat = 0
        var descent: CGFloat = 0
        var width: CGFloat = 0
        let line: CTLineRef = CTLineCreateWithAttributedString(attrString)
        width = CGFloat(CTLineGetTypographicBounds(line, &ascent, &descent, nil))
        
        // make width an even integer for better graphics rendering
        width = ceil(width)
        if Int(width)%2 == 1 {
            width += 1.0
        }
        
        return CGSize(width: width, height: ceil(ascent+descent))
    }
}

// MARK: - Key Text Layer Class

class KeyboardKeyTextLayer: CATextLayer {
    
    // set this to false if not using a mirrored font
    var useMirroredFont = true
    var displayString = ""
    
    override func drawInContext(ctx: CGContext) {
        // A frame is passed in, in which the frame size is already rotated at the center but the content is not.
        
        CGContextSaveGState(ctx)
        
        if useMirroredFont {
            CGContextRotateCTM(ctx, CGFloat(M_PI_2))
            CGContextScaleCTM(ctx, 1.0, -1.0)
        } else {
            CGContextRotateCTM(ctx, CGFloat(M_PI_2))
            CGContextTranslateCTM(ctx, 0, -self.bounds.width)
        }
        
        super.drawInContext(ctx)
        CGContextRestoreGState(ctx)
    }
}


