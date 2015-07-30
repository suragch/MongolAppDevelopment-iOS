import UIKit

class TextViewDemoVC: UIViewController {
    
    
    @IBOutlet weak var textView: UIMongolTextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //myUITextView.font = UIFont(name: "ChimeeWhiteMirrored", size: myUITextView.font.pointSize)
        //myUITextView.setTheFont("ChimeeWhiteMirrored")
        
        print(textView.text)
        
        
        let renderer = MongolUnicodeRenderer()
        
        //var myMongolString = renderer.unicodeToGlyphs("Mongol ᠵᠠᠬᠢᠶ᠎ᠠ ᠶᠢ ᠳᠣᠪᠴᠢᠳᠠᠪᠠᠯ")
        //print(myMongolString)
        
        textView.text = renderer.unicodeToGlyphs(textView.text)
    }
    
    
}