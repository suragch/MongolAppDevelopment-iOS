
import UIKit

@IBDesignable class UIMongolTableView: UIView {
    
    // ********* Unique to TableView *********
    private var view = UITableView()
    
    func setup() {
        // do any setup necessary
        
        //view.text = self.text
        view.backgroundColor = self.backgroundColor
        //view.font = UIFont(name: mongolFontName, size: 24)
    }
    
    // FIXME: @IBOutlet still can't be set in IB
    @IBOutlet weak var delegate: UITableViewDelegate? {
        get {
            return view.delegate
        }
        set {
            view.delegate = newValue
        }
    }
    
    // FIXME: @IBOutlet still can't be set in IB
    @IBOutlet weak var dataSource: UITableViewDataSource? {
        get {
            return view.dataSource
        }
        set {
            view.dataSource = newValue
        }
    }
    
    func registerClass(cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        view.registerClass(cellClass, forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusableCellWithIdentifier(identifier: String) -> UITableViewCell? {
        return view.dequeueReusableCellWithIdentifier(identifier)
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
        
        // Remove the old rotation view
        if self.subviews.count > 0 {
            self.subviews[0].removeFromSuperview()
        }
        
        // setup rotationView container
        let rotationView = UIView()
        rotationView.frame = CGRect(origin: CGPointZero, size: CGSize(width: self.bounds.height, height: self.bounds.width))
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
        transform = CGAffineTransformScale(transform, CGFloat(-1), CGFloat(1))
        
        return transform
    }
}
