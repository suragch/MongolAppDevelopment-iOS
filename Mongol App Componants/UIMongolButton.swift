import UIKit

@IBDesignable class UIMongolButton: UIControl {
    
    // MARK:- Unique to Button
    
    // ********* Unique to Button *********
    private let view = UIButton()
    private var userInteractionEnabledForSubviews = false
    let mongolFontName = "ChimeeWhiteMirrored"
    let defaultFontSize: CGFloat = 17
    
    func setTitle(title: String, forState: UIControlState) {
        self.view.setTitle(title, forState: forState)
    }
    
    func setTitleColor(color: UIColor, forState: UIControlState) {
        self.view.setTitleColor(color, forState: forState)
    }
    
    @IBInspectable var title: String {
        get {
            return view.titleLabel?.text ?? ""
        }
        set {
            self.setTitle(newValue, forState: UIControlState.Normal)
            //view.titleLabel!.text = newValue
        }
    }
    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        super.beginTrackingWithTouch(touch, withEvent: event)
        
        print("touch began")
        
        return true // return true if needs to respond when touch is dragged
    }
    override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        super.continueTrackingWithTouch(touch, withEvent: event)
        let lastPoint = touch.locationInView(self)
        
        // do something with lastPoint
        print("touching point: \(lastPoint)")
        
        self.sendActionsForControlEvents(UIControlEvents.ValueChanged)
        return true // if want to track at touch location
    }
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        super.endTrackingWithTouch(touch, withEvent: event)
        
        print("touch ended")
    }
    
    
    func setup() {
        
        self.view.setTitleColor(UIColor.blueColor(), forState: .Normal)
        self.view.userInteractionEnabled = userInteractionEnabledForSubviews
        // set font if user didn't specify size in IB
        if self.view.titleLabel?.font.fontName != mongolFontName {
            view.titleLabel!.font = UIFont(name: mongolFontName, size: defaultFontSize)
            
        }
        
    }
    
    
    // MARK:- General code for Mongol views
    
    // *******************************************
    // ****** General code for Mongol views ******
    // *******************************************
    
    private var oldWidth: CGFloat = 0
    private var oldHeight: CGFloat = 0
    
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
        rotationView.frame = CGRect(origin: CGPointZero, size: CGSize(width: self.bounds.height, height: self.bounds.width))
        rotationView.userInteractionEnabled = userInteractionEnabledForSubviews
        self.addSubview(rotationView)
        
        // transform rotationView (so that it covers the same frame as self)
        rotationView.transform = translateRotateFlip()
        
        
        
        // add view
        view.frame = rotationView.bounds
        rotationView.addSubview(view)
        
    }
    
    func translateRotateFlip() -> CGAffineTransform {
        
        var transform = CGAffineTransformIdentity
        
        // translate to new center
        transform = CGAffineTransformTranslate(transform, (self.bounds.width / 2)-(self.bounds.height / 2), (self.bounds.height / 2)-(self.bounds.width / 2))
        // rotate counterclockwise around center
        transform = CGAffineTransformRotate(transform, CGFloat(-M_PI_2))
        // flip vertically
        transform = CGAffineTransformScale(transform, -1, 1)
        
        return transform
    }
    
}

