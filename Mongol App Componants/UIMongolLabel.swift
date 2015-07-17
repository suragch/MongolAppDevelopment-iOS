import UIKit

@IBDesignable class UIMongolLabel: UIView {
    
    // properties
    private var rotationView: UIView!
    private var oldWidth: CGFloat = 0
    private var oldHeight: CGFloat = 0
    @IBInspectable var text: String = ""
    let mongolFontName: String! = "ChimeeWhiteMirrored"
    
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
    
    func setup() {
        
        // 1-10: ᠨᠢᠭᠡ ᠬᠣᠶᠠᠷ ᠭᠤᠷᠪᠠ ᠳᠦᠷᠪᠡ ᠲᠠᠪᠤ ᠳᠣᠯᠣᠭ᠎ᠠ ᠨᠠᠢ᠌ᠮᠠ ᠶᠢᠰᠦ ᠠᠷᠪᠠ
        //text =  "rendered   "
        //text =  "ᠨᠢᠭᠡ ᠬᠣᠶᠠᠷ ᠭᠤᠷᠪᠠ"
        
        //let renderer = MongolUnicodeRenderer()
        
        //text = renderer.unicodeToGlyphs(text)
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
        
        // Remove old rotationView if it exists
        if rotationView != nil && rotationView.isDescendantOfView(self) {
            self.rotationView.removeFromSuperview()
        }
        
        // setup rotationView container
        rotationView = UIView(frame: self.frame)
        rotationView.frame = CGRect(origin: CGPointZero, size: CGSize(width: self.bounds.height, height: self.bounds.width))
        self.addSubview(rotationView)
        
        // setup UITextView
        let labelView = UILabel(frame: rotationView.bounds)
        labelView.backgroundColor = self.backgroundColor // TODO make a different setter
        labelView.text = self.text
        labelView.font = UIFont(name: mongolFontName, size: 24)
        rotationView.addSubview(labelView)
        
        // rotate, translate, flip (so that container view covers same frame as self)
        var transform = CGAffineTransformIdentity
        transform = CGAffineTransformTranslate(transform, (rotationView.bounds.height / 2)-(rotationView.bounds.width / 2), (rotationView.bounds.width / 2)-(rotationView.bounds.height / 2))
        transform = CGAffineTransformRotate(transform, CGFloat(-M_PI_2))
        
        transform = CGAffineTransformScale(transform, CGFloat(-1), CGFloat(1))
        rotationView.transform = transform
    }
    
}

