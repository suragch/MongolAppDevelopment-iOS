
import UIKit

@IBDesignable class UIMongolTableView: UIView {
    
    // MARK:- Unique to TableView
    
    // ********* Unique to TableView *********
    private var view = UITableView()
    private let rotationView = UIView()
    private var userInteractionEnabledForSubviews = true
    
    // read only refernce to the underlying tableview
    var tableView: UITableView {
        get {
            return view
        }
    }
    
    func setup() {
        // do any setup necessary
        
        self.addSubview(rotationView)
        rotationView.addSubview(view)
        
        view.backgroundColor = self.backgroundColor
        view.layoutMargins = UIEdgeInsetsZero
        view.separatorInset = UIEdgeInsetsZero
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
    
    @IBInspectable var scrollEnabled: Bool {
        get {
            return view.scrollEnabled
        }
        set {
            view.scrollEnabled = newValue
        }
    }
    
    
    func scrollToRowAtIndexPath(indexPath: NSIndexPath, atScrollPosition: UITableViewScrollPosition, animated: Bool) {
        view.scrollToRowAtIndexPath(indexPath, atScrollPosition: atScrollPosition, animated: animated)
    }
    
    func registerClass(cellClass: AnyClass?, forCellReuseIdentifier identifier: String) {
        view.registerClass(cellClass, forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusableCellWithIdentifier(identifier: String) -> UITableViewCell? {
        return view.dequeueReusableCellWithIdentifier(identifier)
    }
    
    func reloadData() {
        view.reloadData()
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
        
        rotationView.transform = CGAffineTransformIdentity
        rotationView.frame = CGRect(origin: CGPointZero, size: CGSize(width: self.bounds.height, height: self.bounds.width))
        rotationView.transform = translateRotateFlip()
        
        view.frame = rotationView.bounds
        
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
