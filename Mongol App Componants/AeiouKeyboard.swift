import UIKit

// View Controllers must adapt this protocol
protocol KeyboardDelegate: class {
    func keyWasTapped(_ character: String)
    func keyBackspace()
    func keyNewKeyboardChosen(_ keyboardName: String)
    func charBeforeCursor() -> String?
}

class AeiouKeyboard: UIView, KeyboardKeyDelegate {
    
    weak var delegate: KeyboardDelegate? // probably the view controller
    
    fileprivate let renderer = MongolUnicodeRenderer.sharedInstance
    fileprivate var punctuationOn = false
    fileprivate let nirugu = "\u{180a}"
    fileprivate let fvs1 = "\u{180b}"
    fileprivate let fvs2 = "\u{180c}"
    fileprivate let fvs3 = "\u{180d}"
    
    // Keyboard Keys
    
    // Row 1
    fileprivate let keyA = KeyboardTextKey()
    fileprivate let keyE = KeyboardTextKey()
    fileprivate let keyI = KeyboardTextKey()
    fileprivate let keyO = KeyboardTextKey()
    fileprivate let keyU = KeyboardTextKey()
    
    // Row 2
    fileprivate let keyNA = KeyboardTextKey()
    fileprivate let keyBA = KeyboardTextKey()
    fileprivate let keyQA = KeyboardTextKey()
    fileprivate let keyGA = KeyboardTextKey()
    fileprivate let keyMA = KeyboardTextKey()
    fileprivate let keyLA = KeyboardTextKey()
    
    // Row 3
    fileprivate let keySA = KeyboardTextKey()
    fileprivate let keyDA = KeyboardTextKey()
    fileprivate let keyCHA = KeyboardTextKey()
    fileprivate let keyJA = KeyboardTextKey()
    fileprivate let keyYA = KeyboardTextKey()
    fileprivate let keyRA = KeyboardTextKey()
    
    // Row 4
    fileprivate let keyFVS = KeyboardFvsKey()
    fileprivate let keyMVS = KeyboardTextKey()
    fileprivate let keyWA = KeyboardTextKey()
    fileprivate let keyZA = KeyboardTextKey()
    fileprivate let keySuffix = KeyboardTextKey()
    fileprivate let keyBackspace = KeyboardImageKey()
    
    // Row 5
    fileprivate let keyKeyboard = KeyboardChooserKey()
    fileprivate let keyComma = KeyboardTextKey()
    fileprivate let keySpace = KeyboardImageKey()
    fileprivate let keyQuestion = KeyboardTextKey()
    fileprivate let keyReturn = KeyboardImageKey()
    
    
    
    // MARK:- keyboard initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    fileprivate func setup() {
        
        
        addSubviews()
        initializeNonChangingKeys()
        setMongolKeyStrings()
        assignDelegates()
        
    }
    
    fileprivate func addSubviews() {
        // Row 1
        self.addSubview(keyA)
        self.addSubview(keyE)
        self.addSubview(keyI)
        self.addSubview(keyO)
        self.addSubview(keyU)
        
        // Row 2
        self.addSubview(keyNA)
        self.addSubview(keyBA)
        self.addSubview(keyQA)
        self.addSubview(keyGA)
        self.addSubview(keyMA)
        self.addSubview(keyLA)
        
        // Row 3
        self.addSubview(keySA)
        self.addSubview(keyDA)
        self.addSubview(keyCHA)
        self.addSubview(keyJA)
        self.addSubview(keyYA)
        self.addSubview(keyRA)
        
        // Row 4
        self.addSubview(keyFVS)
        self.addSubview(keyMVS)
        self.addSubview(keyWA)
        self.addSubview(keyZA)
        self.addSubview(keySuffix)
        self.addSubview(keyBackspace)
        
        // Row 5
        self.addSubview(keyKeyboard)
        self.addSubview(keyComma)
        self.addSubview(keySpace)
        self.addSubview(keyQuestion)
        self.addSubview(keyReturn)
        
        
    }
    
    fileprivate func initializeNonChangingKeys() {
        
        
        // Row 4
        keyFVS.setStrings("", fvs2Top: "", fvs3Top: "", fvs1Bottom: "", fvs2Bottom: "", fvs3Bottom: "")
        keyMVS.primaryString = "\u{180E}" // MVS
        keyMVS.primaryStringDisplayOverride = "  " // na ma ga
        keyMVS.primaryStringFontSize = 14.0
        keyMVS.secondaryString = "\u{200D}" // ZWJ
        keyMVS.secondaryStringDisplayOverride = "-" // TODO:
        
        keySuffix.primaryString = "\u{202F}" // NNBS
        keySuffix.primaryStringDisplayOverride = "  " // yi du un
        keySuffix.primaryStringFontSize = 14.0
        keyBackspace.image = UIImage(named: "backspace_dark")
        keyBackspace.keyType = KeyboardImageKey.KeyType.backspace
        keyBackspace.repeatOnLongPress = true
        
        // Row 5
        keyKeyboard.image = UIImage(named: "keyboard_dark")
        keyComma.primaryString = "\u{1802}" // mongol comma
        keyComma.secondaryString = "\u{1803}" // mongol period
        keySpace.primaryString = " "
        keySpace.image = UIImage(named: "space_dark")
        keySpace.repeatOnLongPress = true
        keyQuestion.primaryString = "?"
        keyQuestion.secondaryString = "!"
        keyReturn.image = UIImage(named: "return_dark")
    }
    
    fileprivate func setMongolKeyStrings() {
        
        // Row 1
        keyA.primaryString = "ᠠ"
        keyA.secondaryString = "᠊"
        keyA.secondaryStringDisplayOverride = ""
        keyE.primaryString = "ᠡ"
        keyE.secondaryString = "ᠧ"
        keyI.primaryString = "ᠢ"
        keyI.secondaryString = ""
        keyO.primaryString = "ᠤ"
        keyO.primaryStringDisplayOverride = ""
        keyO.secondaryString = "ᠣ"
        keyU.primaryString = "ᠦ"
        keyU.primaryStringDisplayOverride = ""
        keyU.secondaryString = "ᠥ"
        
        // Row 2
        keyNA.primaryString = "ᠨ"
        keyNA.secondaryString = "ᠩ"
        keyBA.primaryString = "ᠪ"
        keyBA.secondaryString = "ᠫ"
        keyQA.primaryString = "ᠬ"
        keyQA.secondaryString = "ᠾ"
        keyGA.primaryString = "ᠭ"
        keyGA.secondaryString = "ᠺ"
        keyMA.primaryString = "ᠮ"
        keyMA.secondaryString = ""
        keyLA.primaryString = "ᠯ"
        keyLA.secondaryString = "ᡀ"
        
        // Row 3
        keySA.primaryString = "ᠰ"
        keySA.secondaryString = "ᠱ"
        keyDA.primaryString = "ᠳ"
        keyDA.secondaryString = "ᠲ"
        keyCHA.primaryString = "ᠴ"
        keyCHA.secondaryString = "ᡂ"
        keyJA.primaryString = "ᠵ"
        keyJA.secondaryString = "ᡁ"
        keyYA.primaryString = "ᠶ"
        keyYA.secondaryString = ""
        keyRA.primaryString = "ᠷ"
        keyRA.secondaryString = "ᠿ"
        
        // Row 4
        keyWA.primaryString = "ᠸ"
        keyWA.secondaryString = "ᠹ"
        keyZA.primaryString = "ᠽ"
        keyZA.secondaryString = "ᠼ"
        
    }
    
    fileprivate func setPunctuationKeyStrings() {
        
        // Row 1
        keyA.primaryString = "("
        keyA.secondaryString = "["
        keyE.primaryString = ")"
        keyE.secondaryString = "]"
        keyI.primaryString = "«"
        keyI.secondaryString = "<"
        keyO.primaryString = "»"
        keyO.secondaryString = ">"
        keyU.primaryString = "·"
        keyU.secondaryString = "᠁"
        
        // Row 2
        keyNA.primaryString = "1"
        keyNA.secondaryString = "᠑"
        keyBA.primaryString = "2"
        keyBA.secondaryString = "᠒"
        keyQA.primaryString = "3"
        keyQA.secondaryString = "᠓"
        keyGA.primaryString = "4"
        keyGA.secondaryString = "᠔"
        keyMA.primaryString = "5"
        keyMA.secondaryString = "᠕"
        keyLA.primaryString = "︱"
        keyLA.secondaryString = "᠀"
        
        // Row 3
        keySA.primaryString = "6"
        keySA.secondaryString = "᠖"
        keyDA.primaryString = "7"
        keyDA.secondaryString = "᠗"
        keyCHA.primaryString = "8"
        keyCHA.secondaryString = "᠘"
        keyJA.primaryString = "9"
        keyJA.secondaryString = "᠙"
        keyYA.primaryString = "0"
        keyYA.secondaryString = "᠐"
        keyRA.primaryString = "."
        keyRA.secondaryString = "᠅"
        
        // Row 4
        keyWA.primaryString = "⁈"
        keyWA.secondaryString = "᠄"
        keyZA.primaryString = "‼"
        keyZA.secondaryString = ";"
    }
    
    
    
    fileprivate func assignDelegates() {
        
        // Row 1
        keyA.delegate = self
        keyE.delegate = self
        keyI.delegate = self
        keyO.delegate = self
        keyU.delegate = self
        
        // Row 2
        keyNA.delegate = self
        keyBA.delegate = self
        keyQA.delegate = self
        keyGA.delegate = self
        keyMA.delegate = self
        keyLA.delegate = self
        
        // Row 3
        keySA.delegate = self
        keyDA.delegate = self
        keyCHA.delegate = self
        keyJA.delegate = self
        keyYA.delegate = self
        keyRA.delegate = self
        
        // Row 4
        keyFVS.delegate = self
        keyMVS.delegate = self
        keyWA.delegate = self
        keyZA.delegate = self
        keySuffix.delegate = self
        keyBackspace.delegate = self
        //keyBackspace.addTarget(self, action: "keyBackspaceTapped", forControlEvents: UIControlEvents.TouchUpInside)
        
        // Row 5
        //keyKeyboard.addTarget(self, action: "keyKeyboardTapped", forControlEvents: UIControlEvents.TouchUpInside)
        keyKeyboard.delegate = self
        keyComma.delegate = self
        keySpace.delegate = self
        keyQuestion.delegate = self
        keyReturn.addTarget(self, action: #selector(keyReturnTapped), for: UIControlEvents.touchUpInside)

    }
    
    override func layoutSubviews() {
        // TODO: - should add autolayout constraints instead
        
        // |  A |  E | I | O  | U  |    Row 1
        // | N | B | Q | G | M | L |    Row 2
        // | S | D | Ch| J | Y | R |    Row 3
        // |fvs|mvs| W | Z |nbs|del|    Row 4
        // |123| . | space | ? |ret|    Row 5
        
        //let suggestionBarWidth: CGFloat = 30
        let numberOfRows: CGFloat = 5
        let keyUnitsInRow1: CGFloat = 5
        let keyUnitsInRow2to5: CGFloat = 6
        let rowHeight = self.bounds.height / numberOfRows
        let row1KeyUnitWidth = self.bounds.width / keyUnitsInRow1
        let row2to5KeyUnitWidth = self.bounds.width / keyUnitsInRow2to5
        
        // Row 1
        
        keyA.frame = CGRect(x: row1KeyUnitWidth*0, y: 0, width: row1KeyUnitWidth, height: rowHeight)
        keyE.frame = CGRect(x: row1KeyUnitWidth*1, y: 0, width: row1KeyUnitWidth, height: rowHeight)
        keyI.frame = CGRect(x: row1KeyUnitWidth*2, y: 0, width: row1KeyUnitWidth, height: rowHeight)
        keyO.frame = CGRect(x: row1KeyUnitWidth*3, y: 0, width: row1KeyUnitWidth, height: rowHeight)
        keyU.frame = CGRect(x: row1KeyUnitWidth*4, y: 0, width: row1KeyUnitWidth, height: rowHeight)
        
        // Row 2
        keyNA.frame = CGRect(x: row2to5KeyUnitWidth*0, y: rowHeight, width: row2to5KeyUnitWidth, height: rowHeight)
        keyBA.frame = CGRect(x: row2to5KeyUnitWidth*1, y: rowHeight, width: row2to5KeyUnitWidth, height: rowHeight)
        keyQA.frame = CGRect(x: row2to5KeyUnitWidth*2, y: rowHeight, width: row2to5KeyUnitWidth, height: rowHeight)
        keyGA.frame = CGRect(x: row2to5KeyUnitWidth*3, y: rowHeight, width: row2to5KeyUnitWidth, height: rowHeight)
        keyMA.frame = CGRect(x: row2to5KeyUnitWidth*4, y: rowHeight, width: row2to5KeyUnitWidth, height: rowHeight)
        keyLA.frame = CGRect(x: row2to5KeyUnitWidth*5, y: rowHeight, width: row2to5KeyUnitWidth, height: rowHeight)
        
        // Row 3
        keySA.frame = CGRect(x: row2to5KeyUnitWidth*0, y: rowHeight*2, width: row2to5KeyUnitWidth, height: rowHeight)
        keyDA.frame = CGRect(x: row2to5KeyUnitWidth*1, y: rowHeight*2, width: row2to5KeyUnitWidth, height: rowHeight)
        keyCHA.frame = CGRect(x: row2to5KeyUnitWidth*2, y: rowHeight*2, width: row2to5KeyUnitWidth, height: rowHeight)
        keyJA.frame = CGRect(x: row2to5KeyUnitWidth*3, y: rowHeight*2, width: row2to5KeyUnitWidth, height: rowHeight)
        keyYA.frame = CGRect(x: row2to5KeyUnitWidth*4, y: rowHeight*2, width: row2to5KeyUnitWidth, height: rowHeight)
        keyRA.frame = CGRect(x: row2to5KeyUnitWidth*5, y: rowHeight*2, width: row2to5KeyUnitWidth, height: rowHeight)
        
        // Row 4
        keyFVS.frame = CGRect(x: row2to5KeyUnitWidth*0, y: rowHeight*3, width: row2to5KeyUnitWidth, height: rowHeight)
        keyMVS.frame = CGRect(x: row2to5KeyUnitWidth*1, y: rowHeight*3, width: row2to5KeyUnitWidth, height: rowHeight)
        keyWA.frame = CGRect(x: row2to5KeyUnitWidth*2, y: rowHeight*3, width: row2to5KeyUnitWidth, height: rowHeight)
        keyZA.frame = CGRect(x: row2to5KeyUnitWidth*3, y: rowHeight*3, width: row2to5KeyUnitWidth, height: rowHeight)
        keySuffix.frame = CGRect(x: row2to5KeyUnitWidth*4, y: rowHeight*3, width: row2to5KeyUnitWidth, height: rowHeight)
        keyBackspace.frame = CGRect(x: row2to5KeyUnitWidth*5, y: rowHeight*3, width: row2to5KeyUnitWidth, height: rowHeight)
        
        // Row 5
        keyKeyboard.frame = CGRect(x: row2to5KeyUnitWidth*0, y: rowHeight*4, width: row2to5KeyUnitWidth, height: rowHeight)
        keyComma.frame = CGRect(x: row2to5KeyUnitWidth*1, y: rowHeight*4, width: row2to5KeyUnitWidth, height: rowHeight)
        keySpace.frame = CGRect(x: row2to5KeyUnitWidth*2, y: rowHeight*4, width: row2to5KeyUnitWidth*2, height: rowHeight)
        keyQuestion.frame = CGRect(x: row2to5KeyUnitWidth*4, y: rowHeight*4, width: row2to5KeyUnitWidth, height: rowHeight)
        keyReturn.frame = CGRect(x: row2to5KeyUnitWidth*5, y: rowHeight*4, width: row2to5KeyUnitWidth, height: rowHeight)
        
    }
    
    // MARK: - Other
    
    func otherAvailableKeyboards(_ displayNames: [String]) {
        keyKeyboard.menuItems = displayNames
    }
    
    func updateFvsKey(_ previousChar: String?, currentChar: String) {
        
        // get the last character (previousChar is not necessarily a single char)
        var lastChar: UInt32 = 0
        if let previous = previousChar {
            for c in previous.unicodeScalars {
                lastChar = c.value
            }
        }
        
        // lookup the strings and update the key
        if renderer.isMongolian(lastChar) { // Medial or Final
            
            // Medial on top
            var fvs1Top = ""
            if let search = renderer.medialGlyphForUnicode(currentChar + fvs1) {
                fvs1Top = search
            }
            var fvs2Top = ""
            if let search = renderer.medialGlyphForUnicode(currentChar + fvs2) {
                fvs2Top = search
            }
            var fvs3Top = ""
            if let search = renderer.medialGlyphForUnicode(currentChar + fvs3) {
                fvs3Top = search
            }
            
            // Final on bottom
            var fvs1Bottom = ""
            if let search = renderer.finalGlyphForUnicode(currentChar + fvs1) {
                fvs1Bottom = search
            }
            var fvs2Bottom = ""
            if let search = renderer.finalGlyphForUnicode(currentChar + fvs2) {
                fvs2Bottom = search
            }
            var fvs3Bottom = ""
            if let search = renderer.finalGlyphForUnicode(currentChar + fvs3) {
                fvs3Bottom = search
            }
            
            keyFVS.setStrings(fvs1Top, fvs2Top: fvs2Top, fvs3Top: fvs3Top, fvs1Bottom: fvs1Bottom, fvs2Bottom: fvs2Bottom, fvs3Bottom: fvs3Bottom)
            
        } else { // Initial or Isolate
            
            // Initial on top
            var fvs1Top = ""
            if let search = renderer.initialGlyphForUnicode(currentChar + fvs1) {
                fvs1Top = search
            }
            var fvs2Top = ""
            if let search = renderer.initialGlyphForUnicode(currentChar + fvs2) {
                fvs2Top = search
            }
            var fvs3Top = ""
            if let search = renderer.initialGlyphForUnicode(currentChar + fvs3) {
                fvs3Top = search
            }
            
            // Isolate on bottom
            var fvs1Bottom = ""
            if let search = renderer.isolateGlyphForUnicode(currentChar + fvs1) {
                fvs1Bottom = search
            }
            var fvs2Bottom = ""
            if let search = renderer.isolateGlyphForUnicode(currentChar + fvs2) {
                fvs2Bottom = search
            }
            var fvs3Bottom = ""
            if let search = renderer.isolateGlyphForUnicode(currentChar + fvs3) {
                fvs3Bottom = search
            }
            
            keyFVS.setStrings(fvs1Top, fvs2Top: fvs2Top, fvs3Top: fvs3Top, fvs1Bottom: fvs1Bottom, fvs2Bottom: fvs2Bottom, fvs3Bottom: fvs3Bottom)
        }
    }
    
    // MARK: - KeyboardKeyDelegate protocol
    
    func keyTextEntered(_ keyText: String) {
        print("key text: \(keyText)")
        // pass the input up to the Keyboard delegate
        let previousChar = self.delegate?.charBeforeCursor()
        updateFvsKey(previousChar, currentChar: keyText)
        
        self.delegate?.keyWasTapped(keyText)
    }
    
    func keyBackspaceTapped() {
        self.delegate?.keyBackspace()
        print("key text: backspace")
        
        updateFvsKey("", currentChar: "")
    }
    
    func keyReturnTapped() {
        self.delegate?.keyWasTapped("\n")
        print("key text: return")
        
        updateFvsKey("", currentChar: "")
    }
    
    func keyFvsTapped(_ fvs: String) {
        print("key text: fvs")
        self.delegate?.keyWasTapped(fvs)
    }
    
    func keyKeyboardTapped() {
        print("key text: keyboard")
        
        // switch punctuation
        punctuationOn = !punctuationOn
        
        if punctuationOn {
            setPunctuationKeyStrings()
        } else {
            setMongolKeyStrings()
        }
        
        updateFvsKey("", currentChar: "")
    }
    
    // tell the view controller to switch keyboards
    func keyNewKeyboardChosen(_ keyboardName: String) {
        delegate?.keyNewKeyboardChosen(keyboardName)
        updateFvsKey("", currentChar: "")
    }
    
}
