// This keyboard key has two text string locations for horizontal English/Cyrillic script, one centered and one in the bottom right.


import UIKit

@IBDesignable
class KeyboardEnglishTextKey: KeyboardKey {
    

    fileprivate let primaryLayer = CATextLayer()
    fileprivate let secondaryLayer = CATextLayer()
    let secondaryLayerMargin: CGFloat = 5.0
    fileprivate var oldFrame = CGRect.zero
    
    // MARK: Primary input value
    
    @IBInspectable var primaryString: String = "" {
        didSet {
            //primaryLayer.displayString = primaryString
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
            //secondaryLayer.displayString = secondaryString
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
            if frame != CGRect.zero && frame != oldFrame {
                updatePrimaryLayerFrame()
                updateSecondaryLayerFrame()
                oldFrame = frame
            }
            
            
        }
    }
    
    func setup() {
        
        
        // Primary text layer
        //primaryLayer.useMirroredFont = useMirroredFont
        primaryLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(primaryLayer)
        
        // Secondary text layer
        //secondaryLayer.useMirroredFont = useMirroredFont
        secondaryLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(secondaryLayer)
        
        
    }
    
    func updatePrimaryLayerFrame() {
        
        let myAttribute = [ NSFontAttributeName: UIFont.systemFont(ofSize: primaryStringFontSize) ]
        //let myString = primaryLayer.string as? String ?? ""
        let attrString = NSMutableAttributedString(string: primaryString, attributes: myAttribute )
        let size = dimensionsForAttributedString(attrString)
        
        // This is the frame for the soon-to-be rotated layer
        let x = (layer.bounds.width - size.width) / 2
        let y = (layer.bounds.height - size.height) / 2
        primaryLayer.frame = CGRect(x: x, y: y, width: size.width, height: size.height)
        primaryLayer.string = attrString
    }
    
    func updateSecondaryLayerFrame() {
        let myAttribute = [ NSFontAttributeName: UIFont.systemFont(ofSize: secondaryStringFontSize) ]
        
        //let myString = secondaryString  // secondaryLayer.string as? String ?? ""
        let attrString = NSMutableAttributedString(string: secondaryString, attributes: myAttribute )
        let size = dimensionsForAttributedString(attrString)
        
        // This is the frame for the soon-to-be rotated layer
        let x = layer.bounds.width - size.width - secondaryLayerMargin
        let y = layer.bounds.height - size.height - secondaryLayerMargin
        secondaryLayer.frame = CGRect(x: x, y: y, width: size.width, height: size.height)
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

