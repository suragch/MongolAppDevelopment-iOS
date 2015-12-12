import UIKit

// View Controllers must adapt this protocol
protocol KeyboardDelegate {
    func keyWasTapped(character: String)
}

class AeiouKeyboard: UIView, KeyboardKeyDelegate {
    
    var delegate: KeyboardDelegate?
    
    // MARK:- Outlets
    
    @IBOutlet weak var keyA: KeyboardKey!
    @IBOutlet weak var keyE: KeyboardKey!
    @IBOutlet weak var keyI: KeyboardKey!
    @IBOutlet weak var keyO: KeyboardKey!
    @IBOutlet weak var keyU: KeyboardKey!
    @IBOutlet weak var keyNA: KeyboardKey!
    @IBOutlet weak var keyBA: KeyboardKey!
    @IBOutlet weak var keyQA: KeyboardKey!
    @IBOutlet weak var keyGA: KeyboardKey!
    @IBOutlet weak var keyMA: KeyboardKey!
    @IBOutlet weak var keyLA: KeyboardKey!
    @IBOutlet weak var keySA: KeyboardKey!
    @IBOutlet weak var keyDA: KeyboardKey!
    @IBOutlet weak var keyCHA: KeyboardKey!
    @IBOutlet weak var keyJA: KeyboardKey!
    @IBOutlet weak var keyYA: KeyboardKey!
    @IBOutlet weak var keyRA: KeyboardKey!
    @IBOutlet weak var keyWA: KeyboardKey!
    @IBOutlet weak var keyZA: KeyboardKey!
    
    
    
    // MARK:- keyboard initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeSubviews()
        //setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
        //setup()
    }
    
    func initializeSubviews() {
        let xibFileName = "AeiouKeyboard"
        let view = NSBundle.mainBundle().loadNibNamed(xibFileName, owner: self, options: nil)[0] as! UIView
        self.addSubview(view)
        view.frame = self.bounds
    }
    
    func setup() {
        
        keyA.delegate = self
        keyE.delegate = self
        keyI.delegate = self
        keyO.delegate = self
        keyU.delegate = self
        keyNA.delegate = self
        keyBA.delegate = self
        keyQA.delegate = self
        keyGA.delegate = self
        keyMA.delegate = self
        keyLA.delegate = self
        keySA.delegate = self
        keyDA.delegate = self
        keyCHA.delegate = self
        keyJA.delegate = self
        keyYA.delegate = self
        keyRA.delegate = self
        keyWA.delegate = self
        keyZA.delegate = self
    }
    
    // MARK:- Button actions from .xib file
    
//    @IBAction func keyTapped(sender: KeyboardKey) {
//        
//        self.delegate?.keyWasTapped(sender.primaryLetter)
//    }
//    
//    @IBAction func keyLongPressed(sender: KeyboardKey) {
//        
//        self.delegate?.keyWasTapped(sender.secondaryLetter)
//    }
    
    // MARK: - KeyboardKeyDelegate protocol
    
    func keyTextEntered(keyText: String) {
        print("key text: \(keyText)")
        self.delegate?.keyWasTapped(keyText)
    }
    
}