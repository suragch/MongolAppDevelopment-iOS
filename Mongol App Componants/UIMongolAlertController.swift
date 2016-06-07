
import UIKit

class UIMongolAlertController: UIViewController, UIGestureRecognizerDelegate  {

    @IBOutlet weak var alertTitle: UIMongolLabel!
    @IBOutlet weak var alertMessage: UIMongolLabel!
    @IBOutlet weak var alertContainerView: UIView!
    
    let renderer = MongolUnicodeRenderer.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        alertTitle.text = renderer.unicodeToGlyphs(alertTitle.text)
        alertMessage.text = renderer.unicodeToGlyphs(alertMessage.text)
        
        alertContainerView.layer.cornerRadius = 8
        
        // Gesture recognizer to dismiss view
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissMongolAlert))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
        
    }

    func dismissMongolAlert() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
