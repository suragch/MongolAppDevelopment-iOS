
import UIKit

class KeyboardDemoVC: UIViewController, KeyboardDelegate {
    
    @IBOutlet weak var textField: UITextField!
    //@IBOutlet weak var aeiouKeyboard: AeiouKeyboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //aeiouKeyboard.delegate = self
        
        // initialize custom keyboard
        let keyboardView = AeiouKeyboard(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300))
        keyboardView.delegate = self // the view controller will be notified by the keyboard whenever a key is tapped
        
        // replace system keyboard with custom keyboard
        textField.inputView = keyboardView
        textField.becomeFirstResponder()
    }
    
    // required method for keyboard delegate protocol
    func keyWasTapped(character: String) {
        textField.insertText(character)
    }
    
    func keyBackspace() {
        textField.deleteBackward()
    }
}
