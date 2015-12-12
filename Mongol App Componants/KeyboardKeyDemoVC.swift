
import UIKit

class KeyboardKeyDemoVC: UIViewController, KeyboardKeyDelegate {

    let codeKey = KeyboardKey(frame: CGRectZero)
    let renderer = MongolUnicodeRenderer.sharedInstance
    
    @IBOutlet weak var storyboardKey: KeyboardKey!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // code key
        codeKey.delegate = self
        view.addSubview(codeKey)
        
        // storyboard key setup
        storyboardKey.delegate = self
        storyboardKey.primaryLetter = String(UnicodeScalar(MongolUnicodeRenderer.Uni.NA))
        storyboardKey.secondaryLetter = String(UnicodeScalar(MongolUnicodeRenderer.Uni.UE))
        let ueOverride = String(UnicodeScalar(MongolUnicodeRenderer.Uni.UE)) +
            String(UnicodeScalar(MongolUnicodeRenderer.Uni.ZWJ))
        storyboardKey.secondaryLetterDisplayOverride = renderer.unicodeToGlyphs(ueOverride)
        storyboardKey.primaryLetterFontSize = 60
        storyboardKey.secondaryLetterFontSize = 20
        storyboardKey.cornerRadius = 100
        
    }
    
    override func viewDidLayoutSubviews() {
        
        // code key setup
        let margin: CGFloat = 30.0
        codeKey.frame = CGRect(x: margin, y: margin + topLayoutGuide.length,
            width: 100, height: 150.0)
        codeKey.primaryLetter = String(UnicodeScalar(MongolUnicodeRenderer.Uni.GA))
        codeKey.secondaryLetter = String(UnicodeScalar(MongolUnicodeRenderer.Uni.KA))
        codeKey.primaryLetterFontSize = 60
        codeKey.secondaryLetterFontSize = 20
        codeKey.cornerRadius = 20
        codeKey.addTarget(self, action: "codeKeyTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        
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
    
}
