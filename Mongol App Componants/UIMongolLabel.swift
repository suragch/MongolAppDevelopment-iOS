import UIKit

@IBDesignable class UIMongolLabel: UIView {
    
    // TODO: make view resize to label length
    
    // ********* Unique to Label *********
    private let view = UILabel()
    
    let mongolFontName = "ChimeeWhiteMirrored"
    
    @IBInspectable var text: String {
        get {
            if let txt = view.text {
                return txt
            } else {
                return ""
            }
        }
        set {
            view.text = newValue
        }
    }
    
    func setup() {
        
        view.text = self.text
        view.font = UIFont(name: mongolFontName, size: 24)
        
    }
    
    
    
    
    // *******************************************
    // ****** General code for Mongol views ******
    // *******************************************
    
    private var oldWidth: CGFloat = 0
    private var oldHeight: CGFloat = 0
    
    // This method gets called if you create the view in the Interface Builder
    required init(coder aDecoder: NSCoder) {
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
        
        // setup rotationView container
        let rotationView = UIView()
        rotationView.frame = CGRect(origin: CGPointZero, size: CGSize(width: self.bounds.height, height: self.bounds.width))
        self.addSubview(rotationView)
        
        // transform rotationView (so that it covers the same frame as self)
        rotationView.transform = translateRotateFlip()
        
        
        
        // add view (UILabel)
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
        transform = CGAffineTransformScale(transform, CGFloat(-1), CGFloat(1))
        
        return transform
    }
    
}

