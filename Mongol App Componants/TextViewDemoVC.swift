import UIKit

class TextViewDemoVC: UIViewController {
    
    
    @IBOutlet weak var textView: UIMongolTextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(textView.text)
        
        let renderer = MongolUnicodeRenderer.sharedInstance
        textView.text = renderer.unicodeToGlyphs(textView.text)
    }
    
    
}