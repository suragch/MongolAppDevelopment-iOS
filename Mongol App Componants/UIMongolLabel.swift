// UIMongolLabel
// version 1.0

import UIKit

@IBDesignable class UIMongolLabel: UIView {
    
    // TODO: make view resize to label length
    
    // MARK:- Unique to Label
    
    // ********* Unique to Label *********
    fileprivate let view = UILabel()
    fileprivate let rotationView = UIView()
    fileprivate var userInteractionEnabledForSubviews = true
    let mongolFontName = "ChimeeWhiteMirrored"
    let defaultFontSize: CGFloat = 17
    
    @IBInspectable var text: String {
        get {
            return view.text ?? ""
        }
        set {
            view.text = newValue
            view.invalidateIntrinsicContentSize()
        }
    }
        
    @IBInspectable var fontSize: CGFloat {
        get {
            if let font = view.font {
                return font.pointSize
            } else {
                return 0.0
            }
        }
        set {
            view.font = UIFont(name: mongolFontName, size: newValue)
            view.invalidateIntrinsicContentSize()
        }
    }
    
    @IBInspectable var textColor: UIColor {
        get {
            return view.textColor
        }
        set {
            view.textColor = newValue
        }
    }
    
    @IBInspectable var centerText: Bool {
        get {
            return view.textAlignment == NSTextAlignment.center
        }
        set {
            if newValue {
                view.textAlignment = NSTextAlignment.center
            }
        }
    }
    
    @IBInspectable var lines: Int {
        get {
            return view.numberOfLines
        }
        set {
            view.numberOfLines = newValue
        }
    }
    
    var textAlignment: NSTextAlignment {
        get {
            return view.textAlignment
        }
        set {
            view.textAlignment = newValue
        }
    }
    
    var font: UIFont {
        get {
            return view.font
        }
        set {
            view.font = newValue
        }
    }
    
    var adjustsFontSizeToFitWidth: Bool {
        get {
            return view.adjustsFontSizeToFitWidth
        }
        set {
            view.adjustsFontSizeToFitWidth = newValue
        }
    }
    
    var minimumScaleFactor: CGFloat {
        get {
            return view.minimumScaleFactor
        }
        set {
            view.minimumScaleFactor = newValue
        }
    }
    
    override var intrinsicContentSize : CGSize {
        return CGSize(width: view.frame.height, height: view.frame.width)
    }
    
    func setup() {
        
        self.addSubview(rotationView)
        rotationView.addSubview(view)
        
        // set font if user didn't specify size in IB
        if self.view.font.fontName != mongolFontName {
            view.font = UIFont(name: mongolFontName, size: defaultFontSize)
        }
        
    }
    
    
    // MARK:- General code for Mongol views
    
    // *******************************************
    // ****** General code for Mongol views ******
    // *******************************************
    
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
        
        rotationView.transform = CGAffineTransform.identity
        rotationView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: self.bounds.height, height: self.bounds.width))
        rotationView.transform = translateRotateFlip()
        
        view.frame = rotationView.bounds
        
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

