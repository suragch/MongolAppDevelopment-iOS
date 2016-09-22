// UIMongolButton
// version 1.0


import UIKit

@IBDesignable class UIMongolButton: UIControl {
    
    // MARK:- Unique to Button
    
    // ********* Unique to Button *********
    fileprivate let view = UIButton()
    fileprivate var userInteractionEnabledForSubviews = false
    let mongolFontName = "ChimeeWhiteMirrored"
    let defaultFontSize: CGFloat = 17
    
    func setTitle(_ title: String, forState: UIControlState) {
        self.view.setTitle(title, for: forState)
    }
    
    func setTitleColor(_ color: UIColor, forState: UIControlState) {
        self.view.setTitleColor(color, for: forState)
    }
    
    @IBInspectable var title: String {
        get {
            return view.titleLabel?.text ?? ""
        }
        set {
            self.setTitle(newValue, forState: UIControlState())
            //view.titleLabel!.text = newValue
        }
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        
        print("touch began")
        
        return true // return true if needs to respond when touch is dragged
    }
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.continueTracking(touch, with: event)
        let lastPoint = touch.location(in: self)
        
        // do something with lastPoint
        print("touching point: \(lastPoint)")
        
        self.sendActions(for: UIControlEvents.valueChanged)
        return true // if want to track at touch location
    }
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        
        print("touch ended")
    }
    
    
    func setup() {
        
        self.view.setTitleColor(UIColor.blue, for: UIControlState())
        self.view.isUserInteractionEnabled = userInteractionEnabledForSubviews
        // set font if user didn't specify size in IB
        if self.view.titleLabel?.font.fontName != mongolFontName {
            view.titleLabel!.font = UIFont(name: mongolFontName, size: defaultFontSize)
            
        }
        
    }
    
    
    // MARK:- General code for Mongol views
    
    // *******************************************
    // ****** General code for Mongol views ******
    // *******************************************
    
    fileprivate var oldWidth: CGFloat = 0
    fileprivate var oldHeight: CGFloat = 0
    
    // This method gets called if you create the view in the Interface Builder
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // This method gets called if you create the view in code
    override init(frame: CGRect){
        super.init(frame: frame)
        self.setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // layoutSubviews gets called multiple times, only need it once
        if self.frame.height == oldHeight && self.frame.width == oldWidth {
            return
        } else {
            oldWidth = self.frame.width
            oldHeight = self.frame.height
        }
        
        // Remove the old rotation view
        if self.subviews.count > 0 {
            self.subviews[0].removeFromSuperview()
        }
        
        // setup rotationView container
        let rotationView = UIView()
        rotationView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: self.bounds.height, height: self.bounds.width))
        rotationView.isUserInteractionEnabled = userInteractionEnabledForSubviews
        self.addSubview(rotationView)
        
        // transform rotationView (so that it covers the same frame as self)
        rotationView.transform = translateRotateFlip()
        
        
        
        // add view
        view.frame = rotationView.bounds
        rotationView.addSubview(view)
        
    }
    
    func translateRotateFlip() -> CGAffineTransform {
        
        var transform = CGAffineTransform.identity
        
        // translate to new center
        transform = transform.translatedBy(x: (self.bounds.width / 2)-(self.bounds.height / 2), y: (self.bounds.height / 2)-(self.bounds.width / 2))
        // rotate counterclockwise around center
        transform = transform.rotated(by: CGFloat(-M_PI_2))
        // flip vertically
        transform = transform.scaledBy(x: -1, y: 1)
        
        return transform
    }
    
}

