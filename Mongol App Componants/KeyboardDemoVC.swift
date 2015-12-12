
import UIKit

class KeyboardDemoVC: UIViewController, KeyboardDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize custom keyboard
        let keyboardView = AeiouKeyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 300))
        //keyboardView.delegate = self // the view controller will be notified by the keyboard whenever a key is tapped
        
        // replace system keyboard with custom keyboard
        //textField.inputView = keyboardView
    }
    
    // required method for keyboard delegate protocol
    func keyWasTapped(character: String) {
        textField.insertText(character)
    }
}
