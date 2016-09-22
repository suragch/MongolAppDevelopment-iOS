
import UIKit

class KeyboardKeyDemoVC: UIViewController, KeyboardKeyDelegate {

    let codeKey = KeyboardTextKey(frame: CGRect.zero)
    let renderer = MongolUnicodeRenderer.sharedInstance
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        storyboardKey.primaryStringFontSize = 25
        storyboardKey.primaryString = "ᠮᠣᠩᠭᠤᠯ"
        storyboardKey.primaryStringDisplayOverride = renderer.unicodeToGlyphs("ᠮᠣᠩᠭᠤᠯ")
    }
    @IBOutlet weak var storyboardKey: KeyboardTextKey!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // code key
        codeKey.delegate = self
        view.addSubview(codeKey)
        
        // storyboard key setup
        storyboardKey.delegate = self
        storyboardKey.primaryString = MongolUnicodeRenderer.UniString.NA
        storyboardKey.secondaryString = MongolUnicodeRenderer.UniString.UE
        let ueOverride = MongolUnicodeRenderer.UniString.UE +
            MongolUnicodeRenderer.UniString.ZWJ
        storyboardKey.secondaryStringDisplayOverride = renderer.unicodeToGlyphs(ueOverride)
        storyboardKey.primaryStringFontSize = 60
        storyboardKey.secondaryStringFontSize = 20
        storyboardKey.cornerRadius = 100
        
        
        
        
        // code key setup
        let margin: CGFloat = 30.0
        codeKey.frame = CGRect(x: margin, y: margin + 80,
            width: 100, height: 150.0)
        codeKey.primaryString = MongolUnicodeRenderer.UniString.GA
        codeKey.secondaryString = MongolUnicodeRenderer.UniString.NA
        codeKey.primaryStringFontSize = 60
        codeKey.secondaryStringFontSize = 20
        codeKey.cornerRadius = 20
        codeKey.addTarget(self, action: #selector(codeKeyTapped(_:)), for: UIControlEvents.touchUpInside)
        
        
        
        
        // button 
        //let backgroundLayer = KeyboardKeyBackgroundLayer()
        //backgroundLayer.frame = button.bounds
        //button.backgroundColor = UIColor.clearColor()
       // button.layer.addSublayer(backgroundLayer)
    }
    
    // MARK: - Optional methods
    
    func codeKeyTapped(_ key: KeyboardKey) {
        print("Code Key tapped")
    }
    
    @IBAction func storyboardKeyTapped(_ sender: KeyboardKey) {
        print("Storyboard Key tapped")
    }
    
    // MARK: - KeyboardKeyDelegate protocol
    
    func keyTextEntered(_ keyText: String) {
        print("key text: \(keyText)")
    }
    
    func keyBackspaceTapped() {
        print("backspace tapped")
    }
    
    func keyFvsTapped(_ fvs: String) {
        print("key text: fvs")
    }
    
    func keyKeyboardTapped() {
        // for keyboard chooser key
    }
    
    func keyNewKeyboardChosen(_ keyboardName: String) {
        // for keyboard chooser key
    }
    
    func otherAvailableKeyboards(_ displayNames: [String]) {
        // for keyboard chooser key
    }
    
}
