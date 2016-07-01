

import UIKit

class UIMongolAlertView2: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var titleLabel: UIMongolLabel!
    @IBOutlet weak var messageLabel: UIMongolLabel!
    @IBOutlet weak var topButtonLabel: UIMongolLabel!
    @IBOutlet weak var bottomButtonLabel: UIMongolLabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        NSBundle.mainBundle().loadNibNamed("UIMongolAlertView2", owner: self, options: nil)[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
    
}