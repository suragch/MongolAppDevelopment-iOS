// This keyboard key has two text string locations for vertical Mongolian script, one centered and one in the bottom right.


import UIKit

@IBDesignable
class KeyboardImageKey: KeyboardKey {
    
    private let imageLayer = CALayer()
    
    var primaryString: String = ""
    var secondaryString: String = ""
    
    
    @IBInspectable var image: UIImage?
        {
        didSet {
            imageLayer.contents = image?.CGImage
            updateImageLayerFrame()
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
            updateImageLayerFrame()
        }
    }
    
    func setup() {
        
        // image layer
        imageLayer.contentsScale = UIScreen.mainScreen().scale
        layer.addSublayer(imageLayer)
        
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
    
    // long press
    override func longPressBegun() {
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
    
}