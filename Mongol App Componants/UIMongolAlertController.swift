// UIMongolAlertController
// version 1.0



import UIKit

class UIMongolAlertController: UIViewController, UIGestureRecognizerDelegate  {
    
    // TODO: Create this view controller entirely programmatically
    @IBOutlet weak var alertTitle: UIMongolLabel!
    @IBOutlet weak var alertMessage: UIMongolLabel!
    @IBOutlet weak var alertContainerView: UIView!
    @IBOutlet weak var topButton: UIMongolLabel!
    @IBOutlet weak var bottomButton: UIMongolLabel!
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonContainerWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var horizontalDividerWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var verticalDividerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonEqualHeightsConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomButtonHeightConstraint: NSLayoutConstraint!
    
    var titleText: String?
    var messageText: String?
    var numberOfButtons = 1
    var buttonOneText: String?
    var buttonTwoText: String?
    var buttonOneAction: (()->Void)?
    var buttonTwoAction: (()->Void)?
    var alertWidth: CGFloat?
    
    let renderer = MongolUnicodeRenderer.sharedInstance
    fileprivate let buttonTapHighlightColor = UIColor.lightGray
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // all alerts
        view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        widthConstraint.constant = alertWidth ?? 200
        alertContainerView.layer.cornerRadius = 13
        alertContainerView.clipsToBounds = true
        
        if let unwrappedTitle = titleText {
            alertTitle.text = renderer.unicodeToGlyphs(unwrappedTitle)
        }
        if let unwrappedMessage = messageText {
            alertMessage.text = renderer.unicodeToGlyphs(unwrappedMessage)
        }
        
        // No buttons
        
        if numberOfButtons == 0 {
            
            // tap to dismiss
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissMongolAlert))
            tapGesture.delegate = self
            view.addGestureRecognizer(tapGesture)
            
            // hide buttons
            buttonContainerWidthConstraint.constant = 0
            horizontalDividerWidthConstraint.constant = 0            
            
            return
        }
        
        // top button
        
        if let buttonOneText = buttonOneText {
            topButton.text = renderer.unicodeToGlyphs(buttonOneText)
        }
        
        let tapOne = UILongPressGestureRecognizer(target: self, action: #selector(buttonOneHandler))
        tapOne.minimumPressDuration = 0
        topButton.addGestureRecognizer(tapOne)
        
        if numberOfButtons == 1 {
            
            verticalDividerHeightConstraint.constant = 0
            buttonEqualHeightsConstraint.isActive = false
            bottomButtonHeightConstraint.constant = 0
            
            return
        }
        
        // bottom button
        
        if let buttonTwoText = buttonTwoText {
            bottomButton.text = renderer.unicodeToGlyphs(buttonTwoText)
        }
        
        let tapTwo = UILongPressGestureRecognizer(target: self, action: #selector(buttonTwoHandler))
        tapTwo.minimumPressDuration = 0
        bottomButton.addGestureRecognizer(tapTwo)
        
    }
    
    func buttonOneHandler(_ gesture: UITapGestureRecognizer) {
        
        
        if gesture.state == .began{
            topButton.backgroundColor = buttonTapHighlightColor
        } else if gesture.state == UIGestureRecognizerState.changed {
            
            // cancel gesture
            gesture.isEnabled = false
            gesture.isEnabled = true
            topButton.backgroundColor = UIColor.clear
            
        } else if  gesture.state == .ended {
            topButton.backgroundColor = UIColor.clear
            if let action = self.buttonOneAction {
                action()
            }
            
            dismissMongolAlert()
        }
    }
    
    func buttonTwoHandler(_ gesture: UITapGestureRecognizer) {
        
        if gesture.state == .began {
            bottomButton.backgroundColor = buttonTapHighlightColor
        } else if gesture.state == UIGestureRecognizerState.changed {
            
            // cancel gesture
            gesture.isEnabled = false
            gesture.isEnabled = true
            bottomButton.backgroundColor = UIColor.clear
            
        } else if  gesture.state == .ended {
            bottomButton.backgroundColor = UIColor.clear
            if let action = self.buttonTwoAction {
                action()
            }
            dismissMongolAlert()
        }
        
        
        
    }
    
    func dismissMongolAlert() {
        self.dismiss(animated: true, completion: nil)
    }
    

}
