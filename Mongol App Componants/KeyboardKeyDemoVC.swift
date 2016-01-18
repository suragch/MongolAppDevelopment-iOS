
import UIKit

class KeyboardKeyDemoVC: UIViewController, KeyboardKeyDelegate {

    let codeKey = KeyboardTextKey(frame: CGRectZero)
    let renderer = MongolUnicodeRenderer.sharedInstance
    
    @IBOutlet weak var button: UIButton!
    
    @IBAction func buttonTapped(sender: UIButton) {
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
        storyboardKey.primaryString = String(UnicodeScalar(MongolUnicodeRenderer.Uni.NA))
        storyboardKey.secondaryString = String(UnicodeScalar(MongolUnicodeRenderer.Uni.UE))
        let ueOverride = String(UnicodeScalar(MongolUnicodeRenderer.Uni.UE)) +
            String(UnicodeScalar(MongolUnicodeRenderer.Uni.ZWJ))
        storyboardKey.secondaryStringDisplayOverride = renderer.unicodeToGlyphs(ueOverride)
        storyboardKey.primaryStringFontSize = 60
        storyboardKey.secondaryStringFontSize = 20
        storyboardKey.cornerRadius = 100
        
        
        
        
        // code key setup
        let margin: CGFloat = 30.0
        codeKey.frame = CGRect(x: margin, y: margin + 80,
            width: 100, height: 150.0)
        codeKey.primaryString = String(UnicodeScalar(MongolUnicodeRenderer.Uni.GA))
        codeKey.secondaryString = String(UnicodeScalar(MongolUnicodeRenderer.Uni.KA))
        codeKey.primaryStringFontSize = 60
        codeKey.secondaryStringFontSize = 20
        codeKey.cornerRadius = 20
        codeKey.addTarget(self, action: "codeKeyTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        
        
        // button 
        //let backgroundLayer = KeyboardKeyBackgroundLayer()
        //backgroundLayer.frame = button.bounds
        //button.backgroundColor = UIColor.clearColor()
       // button.layer.addSublayer(backgroundLayer)
    }
    
    // MARK: - Optional methods
    
    func codeKeyTapped(key: KeyboardKey) {
        print("Code Key tapped")
    }
    
    @IBAction func storyboardKeyTapped(sender: KeyboardKey) {
        print("Storyboard Key tapped")
    }
    
    // MARK: - KeyboardKeyDelegate protocol
    
    func keyTextEntered(keyText: String) {
        print("key text: \(keyText)")
    }
    
    func keyBackspaceTapped() {
        print("backspace tapped")
    }
    
    func keyKeyboardTapped() {
        // for keyboard chooser key
    }
    
    func keyNewKeyboardChosen(keyboardName: String) {
        // for keyboard chooser key
    }
    
    func otherAvailableKeyboards(displayNames: [String]) {
        // for keyboard chooser key
    }
    
}
