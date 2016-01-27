
import UIKit

class KeyboardDemoVC: UIViewController, KeyboardDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    // keyboards
    var qwertyKeyboard: QwertyKeyboard?
    var aeiouKeyboard: AeiouKeyboard?
    var englishKeyboard: EnglishKeyboard?
    var cyrillicKeyboard: CyrillicKeyboard?
    
    let renderer = MongolUnicodeRenderer.sharedInstance
    
    enum KeyboardName: String {
        case English = "ABC"
        case Cyrillic = "КИРИЛЛ"
        case Aeiou = " " // ᠴᠠᠭᠠᠨ ᠲᠣᠯᠤᠭᠠᠢ
        case Qwerty = "" // ᠺᠤᠮᠫᠢᠦ᠋ᠲ᠋ᠧᠷ
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get strings for keyboard names above
        print(renderer.unicodeToGlyphs("ᠴᠠᠭᠠᠨ ᠲᠣᠯᠤᠭᠠᠢ"))
        print(renderer.unicodeToGlyphs("ᠺᠤᠮᠫᠢᠦ᠋ᠲ᠋ᠧᠷ"))
        
        // default keyboard
        keyNewKeyboardChosen(KeyboardName.Aeiou.rawValue)
        
        
    }
    
    // required methods for keyboard delegate protocol
    func keyWasTapped(character: String) {
        textField.insertText(character)
    }
    
    func keyBackspace() {
        textField.deleteBackward()
    }
    
    func charBeforeCursor() -> String? {
        // get the cursor position
        if let cursorRange = textField.selectedTextRange {
            
            // get the position one character before the cursor start position
            if let newPosition = textField.positionFromPosition(cursorRange.start, inDirection: UITextLayoutDirection.Left, offset: 1) {
                
                let range = textField.textRangeFromPosition(newPosition, toPosition: cursorRange.start)
                return textField.textInRange(range!)
            }
        }
        return nil
    }
    
    func keyNewKeyboardChosen(keyboardName: String) {
        switch keyboardName {
        case KeyboardName.Aeiou.rawValue:
            
            if aeiouKeyboard == nil {
                aeiouKeyboard = AeiouKeyboard(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300))
                aeiouKeyboard?.otherAvailableKeyboards([
                    KeyboardName.English.rawValue,
                    KeyboardName.Cyrillic.rawValue,
                    KeyboardName.Qwerty.rawValue])
                aeiouKeyboard!.delegate = self
            }
            self.view.endEditing(true)
            textField.inputView = aeiouKeyboard
            textField.becomeFirstResponder()
            
        case KeyboardName.Qwerty.rawValue:
            
            if qwertyKeyboard == nil {
                qwertyKeyboard = QwertyKeyboard(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300))
                qwertyKeyboard?.otherAvailableKeyboards([
                    KeyboardName.English.rawValue,
                    KeyboardName.Cyrillic.rawValue,
                    KeyboardName.Aeiou.rawValue])
                qwertyKeyboard!.delegate = self
            }
            self.view.endEditing(true)
            textField.inputView = qwertyKeyboard
            textField.becomeFirstResponder()
            
        case KeyboardName.English.rawValue:
            
            if englishKeyboard == nil {
                englishKeyboard = EnglishKeyboard(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300))
                englishKeyboard?.otherAvailableKeyboards([
                    KeyboardName.Qwerty.rawValue,
                    KeyboardName.Aeiou.rawValue,
                    KeyboardName.Cyrillic.rawValue])
                englishKeyboard!.delegate = self
            }
            self.view.endEditing(true)
            textField.inputView = englishKeyboard
            textField.becomeFirstResponder()
            
        case KeyboardName.Cyrillic.rawValue:
            
            if cyrillicKeyboard == nil {
                cyrillicKeyboard = CyrillicKeyboard(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 300))
                cyrillicKeyboard?.otherAvailableKeyboards([
                    KeyboardName.Qwerty.rawValue,
                    KeyboardName.Aeiou.rawValue,
                    KeyboardName.English.rawValue])
                cyrillicKeyboard!.delegate = self
            }
            self.view.endEditing(true)
            textField.inputView = cyrillicKeyboard
            textField.becomeFirstResponder()
            
        default:
            break
        }
    }
}
