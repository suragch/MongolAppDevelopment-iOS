
import UIKit

enum UIMongolAlertStyle: Int {
    
    case NoButtons = 0
    case OneButton
    case TwoButtons
}

// FIXME: - This custom alert is currently unusable.
// TODO: Subclass UIViewController rather than UIView ???

class UIMongolAlert: UIView {
    
    // MARK: - Properties
    
    // public properties
    var style = UIMongolAlertStyle.OneButton
    var messageText = String("some text")
    
    // private properties
    private let margin = 20
    //private var alertContainer = UIView()
    private var messageTextView = UIMongolTextView(frame: CGRectZero)
    //private var buttons = [UIButton]()
    
    // MARK: - Initialization
    
    // This method gets called if you create the view in code
    init(frame: CGRect, messageText: String){
        super.init(frame: frame)
    
        self.backgroundColor = UIColor.whiteColor()
        
        messageTextView.text = messageText
        self.addSubview(messageTextView)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        messageTextView.frame = CGRect(x: margin, y: margin, width: Int(self.bounds.width) - 2 * margin, height: Int(self.bounds.height) - 2 * margin)
    }
    
    // MARK: - Button Action
    
    func okTap(button: UIButton) {
        print("Button pressed")
    }
    
}
