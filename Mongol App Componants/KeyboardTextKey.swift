// KeyboardTextKey
// version 1.0

// This keyboard key has two text string locations for vertical Mongolian script, one centered and one in the bottom right.

import UIKit

@IBDesignable
class KeyboardTextKey: KeyboardKey {
    
    //private let imageLayer = CALayer()
    fileprivate let primaryLayer = KeyboardKeyTextLayer()
    fileprivate let secondaryLayer = KeyboardKeyTextLayer()
    let secondaryLayerMargin: CGFloat = 5.0
    let mongolFontName = "ChimeeWhiteMirrored"
    var useMirroredFont = true
    fileprivate var oldFrame = CGRect.zero
    
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
    @IBInspectable var primaryStringFontColor: UIColor = UIColor.black {
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
    @IBInspectable var secondaryStringFontColor: UIColor = UIColor.black {
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
            if frame != CGRect.zero && frame != oldFrame {
                updatePrimaryLayerFrame()
                updateSecondaryLayerFrame()
                oldFrame = frame
            }
            
            
        }
    }
    
    func setup() {
        
        
        // Primary text layer
        primaryLayer.useMirroredFont = useMirroredFont
        primaryLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(primaryLayer)
        
        // Secondary text layer
        secondaryLayer.useMirroredFont = useMirroredFont
        secondaryLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(secondaryLayer)
        
        
    }
    
    func updatePrimaryLayerFrame() {
        
        let myAttributes = [
            NSFontAttributeName: UIFont(name: mongolFontName, size: primaryStringFontSize )! ,
            NSForegroundColorAttributeName: primaryStringFontColor
        ] as [String : Any]
        let attrString = NSMutableAttributedString(string: primaryLayer.displayString, attributes: myAttributes )
        let size = dimensionsForAttributedString(attrString)
        
        // This is the frame for the soon-to-be rotated layer
        let x = (layer.bounds.width - size.height) / 2
        let y = (layer.bounds.height - size.width) / 2
        primaryLayer.frame = CGRect(x: x, y: y, width: size.height, height: size.width)
        primaryLayer.string = attrString
    }
    
    func updateSecondaryLayerFrame() {
        
        let myAttributes = [
            NSFontAttributeName: UIFont(name: mongolFontName, size: secondaryStringFontSize )! ,
            NSForegroundColorAttributeName: secondaryStringFontColor
        ] as [String : Any]
        let attrString = NSMutableAttributedString(string: secondaryLayer.displayString, attributes: myAttributes )
        let size = dimensionsForAttributedString(attrString)
        
        // This is the frame for the soon-to-be rotated layer
        let x = layer.bounds.width - size.height - secondaryLayerMargin
        let y = layer.bounds.height - size.width - secondaryLayerMargin
        secondaryLayer.frame = CGRect(x: x, y: y, width: size.height, height: size.width)
        secondaryLayer.string = attrString
    }
    
    
    override func longPressBegun(_ guesture: UILongPressGestureRecognizer) {
        if self.secondaryString != "" {
            delegate?.keyTextEntered(self.secondaryString)
        } else {
            // enter primary string if this key has no seconary string
            delegate?.keyTextEntered(self.primaryString)
        }
    }
    
    // tap event (do when finger lifted)
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        
        delegate?.keyTextEntered(self.primaryString)
        
    }
    
    func dimensionsForAttributedString(_ attrString: NSAttributedString) -> CGSize {
        
        var ascent: CGFloat = 0
        var descent: CGFloat = 0
        var width: CGFloat = 0
        let line: CTLine = CTLineCreateWithAttributedString(attrString)
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
    
    override func draw(in ctx: CGContext) {
        // A frame is passed in, in which the frame size is already rotated at the center but the content is not.
        
        ctx.saveGState()
        
        if useMirroredFont {
            ctx.rotate(by: CGFloat(M_PI_2))
            ctx.scaleBy(x: 1.0, y: -1.0)
        } else {
            ctx.rotate(by: CGFloat(M_PI_2))
            ctx.translateBy(x: 0, y: -self.bounds.width)
        }
        
        super.draw(in: ctx)
        ctx.restoreGState()
    }
}


