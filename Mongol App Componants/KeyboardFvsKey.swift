// This keyboard key has six text string locations for vertical Mongolian script. These are for glyph variations that can be selected with the three FVS (Free Variation Selector) Unicode character. The top three positions are for initial/medial variations and the bottom three are for isolate/final variations.


// This keyboard key has two text string locations for vertical Mongolian script, one centered and one in the bottom right.


import UIKit

@IBDesignable
class KeyboardFvsKey: KeyboardKey {
    
    private let fvs1TopLayer = KeyboardKeyTextLayer()
    private let fvs2TopLayer = KeyboardKeyTextLayer()
    private let fvs3TopLayer = KeyboardKeyTextLayer()
    private let horizonalDividerLayer = CALayer()
    private let fvs1BottomLayer = KeyboardKeyTextLayer()
    private let fvs2BottomLayer = KeyboardKeyTextLayer()
    private let fvs3BottomLayer = KeyboardKeyTextLayer()
    
    let mongolFontName = "ChimeeWhiteMirrored"
    var useMirroredFont = true
    
    // MARK: Primary input value
    
    var primaryString: String = "A"
    
    private var fvs1TopString = ""
    private var fvs2TopString = ""
    private var fvs3TopString = ""
    private var fvs1BottomString = ""
    private var fvs2BottomString = ""
    private var fvs3BottomString = ""
    
    var fontSize: CGFloat = 12 {
        didSet {
            updateTextFrames()
        }
    }
    var dividerColor: UIColor = UIColor.blackColor() // TODO: update text
    
    
    
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
            updateTextFrames()
        }
    }
    
    func setup() {
        //fvs1TopLayer.backgroundColor = UIColor.redColor().CGColor
        //fvs2TopLayer.backgroundColor = UIColor.redColor().CGColor
        //fvs3TopLayer.backgroundColor = UIColor.redColor().CGColor
        //fvs1BottomLayer.backgroundColor = UIColor.redColor().CGColor
        //fvs2BottomLayer.backgroundColor = UIColor.redColor().CGColor
        //fvs3BottomLayer.backgroundColor = UIColor.redColor().CGColor
        
        // FVS1 Top Layer
        fvs1TopLayer.useMirroredFont = useMirroredFont
        fvs1TopLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(fvs1TopLayer)
        
        // FVS2 Top Layer
        fvs2TopLayer.useMirroredFont = useMirroredFont
        fvs2TopLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(fvs2TopLayer)
        
        // FVS3 Top Layer
        fvs3TopLayer.useMirroredFont = useMirroredFont
        fvs3TopLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(fvs3TopLayer)
        
        // Horizonal divider layer
        horizonalDividerLayer.contentsScale = UIScreen.mainScreen().scale
        horizonalDividerLayer.backgroundColor = dividerColor.CGColor
        layer.addSublayer(horizonalDividerLayer)
        
        // FVS1 Bottom Layer
        fvs1BottomLayer.useMirroredFont = useMirroredFont
        fvs1BottomLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(fvs1BottomLayer)
        
        // FVS2 Bottom Layer
        fvs2BottomLayer.useMirroredFont = useMirroredFont
        fvs2BottomLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(fvs2BottomLayer)
        
        // FVS3 Bottom Layer
        fvs3BottomLayer.useMirroredFont = useMirroredFont
        fvs3BottomLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(fvs3BottomLayer)
        
    }
    
    func updateTextFrames() {
        
        let myAttribute = [ NSFontAttributeName: UIFont(name: mongolFontName, size: fontSize )! ]
        
        
        // FVS1 top
        let attrString = NSMutableAttributedString(string: fvs1TopString, attributes: myAttribute )
        var size = dimensionsForAttributedString(attrString)
        var x = (layer.bounds.width - 3*size.height) / 6 + padding
        var y = (layer.bounds.height - 2*size.width) / 4 + padding
        fvs1TopLayer.frame = CGRect(x: x, y: y, width: size.height, height: size.width)
        fvs1TopLayer.string = attrString
        
        // FVS 2 top
        attrString.mutableString.setString(fvs2TopString)
        size = dimensionsForAttributedString(attrString)
        x = (layer.bounds.width - size.height) / 2
        y = (layer.bounds.height - 2*size.width) / 4 + padding
        fvs2TopLayer.frame = CGRect(x: x, y: y, width: size.height, height: size.width)
        fvs2TopLayer.string = attrString
        
        // FVS 3 top
        attrString.mutableString.setString(fvs3TopString)
        size = dimensionsForAttributedString(attrString)
        x = (5*layer.bounds.width - 3*size.height) / 6 - padding
        y = (layer.bounds.height - 2*size.width) / 4 + padding
        fvs3TopLayer.frame = CGRect(x: x, y: y, width: size.height, height: size.width)
        fvs3TopLayer.string = attrString
        
        // Horizontal divider 
        x = padding
        y = layer.bounds.height / 2
        horizonalDividerLayer.frame = CGRect(x: x, y: y, width: layer.bounds.width - 2*padding, height: 1.0)
        
        
        // FVS 1 bottom
        attrString.mutableString.setString(fvs1BottomString)
        size = dimensionsForAttributedString(attrString)
        x = (layer.bounds.width - 3*size.height) / 6 + padding
        y = (3*layer.bounds.height - 2*size.width) / 4 - padding
        fvs1BottomLayer.frame = CGRect(x: x, y: y, width: size.height, height: size.width)
        fvs1BottomLayer.string = attrString
        
        // FVS 2 bottom
        attrString.mutableString.setString(fvs2BottomString)
        size = dimensionsForAttributedString(attrString)
        x = (layer.bounds.width - size.height) / 2
        y = (3*layer.bounds.height - 2*size.width) / 4 - padding
        fvs2BottomLayer.frame = CGRect(x: x, y: y, width: size.height, height: size.width)
        fvs2BottomLayer.string = attrString
        
        // FVS 3 bottom
        attrString.mutableString.setString(fvs3BottomString)
        size = dimensionsForAttributedString(attrString)
        x = (5*layer.bounds.width - 3*size.height) / 6 - padding
        y = (3*layer.bounds.height - 2*size.width) / 4 - padding
        fvs3BottomLayer.frame = CGRect(x: x, y: y, width: size.height, height: size.width)
        fvs3BottomLayer.string = attrString
        
        
    }
    
    
    func setStrings(fvs1Top: String, fvs2Top: String, fvs3Top: String, fvs1Bottom: String, fvs2Bottom: String, fvs3Bottom: String) {
        
        fvs1TopString = fvs1Top
        fvs2TopString = fvs2Top
        fvs3TopString = fvs3Top
        fvs1BottomString = fvs1Bottom
        fvs2BottomString = fvs2Bottom
        fvs3BottomString = fvs3Bottom
        
        updateTextFrames()
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

