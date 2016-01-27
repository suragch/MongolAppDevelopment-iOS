import UIKit

class QwertyKeyboard: UIView, KeyboardKeyDelegate {
    
    weak var delegate: KeyboardDelegate? // probably the view controller
    
    private let renderer = MongolUnicodeRenderer.sharedInstance
    private var punctuationOn = false
    private let nirugu = "\u{180a}"
    private let fvs1 = "\u{180b}"
    private let fvs2 = "\u{180c}"
    private let fvs3 = "\u{180d}"
    
    // Keyboard Keys
    
    // Row 1
    private let keyQ = KeyboardTextKey()
    private let keyW = KeyboardTextKey()
    private let keyE = KeyboardTextKey()
    private let keyR = KeyboardTextKey()
    private let keyT = KeyboardTextKey()
    private let keyY = KeyboardTextKey()
    private let keyU = KeyboardTextKey()
    private let keyI = KeyboardTextKey()
    private let keyO = KeyboardTextKey()
    private let keyP = KeyboardTextKey()
    
    // Row 2
    private let keyA = KeyboardTextKey()
    private let keyS = KeyboardTextKey()
    private let keyD = KeyboardTextKey()
    private let keyF = KeyboardTextKey()
    private let keyG = KeyboardTextKey()
    private let keyH = KeyboardTextKey()
    private let keyJ = KeyboardTextKey()
    private let keyK = KeyboardTextKey()
    private let keyL = KeyboardTextKey()
    private let keyNg = KeyboardTextKey()
    
    // Row 3
    private let keyFVS = KeyboardFvsKey()
    private let keyZ = KeyboardTextKey()
    private let keyX = KeyboardTextKey()
    private let keyC = KeyboardTextKey()
    private let keyV = KeyboardTextKey()
    private let keyB = KeyboardTextKey()
    private let keyN = KeyboardTextKey()
    private let keyM = KeyboardTextKey()
    private let keyBackspace = KeyboardImageKey()
    
    // Row 4
    private let keyKeyboard = KeyboardChooserKey()
    private let keyMVS = KeyboardTextKey()
    private let keyComma = KeyboardTextKey()
    private let keySpace = KeyboardImageKey()
    private let keyQuestion = KeyboardTextKey()
    private let keySuffix = KeyboardTextKey()
    private let keyReturn = KeyboardImageKey()
    
    
    // MARK:- keyboard initialization
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    func setup() {
        
        
        addSubviews()
        initializeNonChangingKeys()
        setMongolKeyStrings()
        assignDelegates()
        
        //print(renderer.unicodeToGlyphs("ᠠᠨ\u{180E}ᠠ ᠠᠮ\u{180E}ᠠ ᠠᠭ\u{180E}ᠠ"))
        //print(renderer.unicodeToGlyphs("\u{202F}ᠶᠢ\u{202F}ᠳᠦ\u{202F}ᠦᠨ"))
    }
    
    func addSubviews() {
        
        // Row 1
        self.addSubview(keyQ)
        self.addSubview(keyW)
        self.addSubview(keyE)
        self.addSubview(keyR)
        self.addSubview(keyT)
        self.addSubview(keyY)
        self.addSubview(keyU)
        self.addSubview(keyI)
        self.addSubview(keyO)
        self.addSubview(keyP)
        
        // Row 2
        self.addSubview(keyA)
        self.addSubview(keyS)
        self.addSubview(keyD)
        self.addSubview(keyF)
        self.addSubview(keyG)
        self.addSubview(keyH)
        self.addSubview(keyJ)
        self.addSubview(keyK)
        self.addSubview(keyL)
        self.addSubview(keyNg)
        
        // Row 3
        self.addSubview(keyFVS)
        self.addSubview(keyZ)
        self.addSubview(keyX)
        self.addSubview(keyC)
        self.addSubview(keyV)
        self.addSubview(keyB)
        self.addSubview(keyN)
        self.addSubview(keyM)
        self.addSubview(keyBackspace)
        
        // Row 4
        self.addSubview(keyKeyboard)
        self.addSubview(keyMVS)
        self.addSubview(keyComma)
        self.addSubview(keySpace)
        self.addSubview(keyQuestion)
        self.addSubview(keySuffix)
        self.addSubview(keyReturn)
        
    }
    
    func initializeNonChangingKeys() {
        
        // Row 3
        keyFVS.setStrings("", fvs2Top: "", fvs3Top: "", fvs1Bottom: "", fvs2Bottom: "", fvs3Bottom: "")
        keyBackspace.image = UIImage(named: "backspace_dark")
        keyBackspace.keyType = KeyboardImageKey.KeyType.Backspace
        keyBackspace.repeatOnLongPress = true
        
        // Row 4
        keyKeyboard.image = UIImage(named: "keyboard_dark")
        keyMVS.primaryString = "\u{180E}" // MVS
        keyMVS.primaryStringDisplayOverride = "  " // na ma ga
        keyMVS.primaryStringFontSize = 14.0
        keyMVS.secondaryString = "\u{200D}" // ZWJ
        keyMVS.secondaryStringDisplayOverride = "-" // TODO:
        keyComma.primaryString = "\u{1802}" // mongol comma
        keyComma.secondaryString = "\u{1803}" // mongol period
        keySpace.primaryString = " "
        keySpace.image = UIImage(named: "space_dark")
        keySpace.repeatOnLongPress = true
        keyQuestion.primaryString = "?"
        keyQuestion.secondaryString = "!"
        keySuffix.primaryString = "\u{202F}" // NNBS
        keySuffix.primaryStringDisplayOverride = "  " // yi du un
        keySuffix.primaryStringFontSize = 14.0
        keyReturn.image = UIImage(named: "return_dark")
    }
    
    func setMongolKeyStrings() {
        
        // Row 1
        keyQ.primaryString = "ᠴ"
        keyQ.secondaryString = "ᡂ"
        keyW.primaryString = "ᠸ"
        keyW.secondaryString = ""
        keyE.primaryString = "ᠡ"
        keyE.secondaryString = "ᠧ"
        keyR.primaryString = "ᠷ"
        keyR.secondaryString = "ᠿ"
        keyT.primaryString = "ᠲ"
        keyT.secondaryString = ""
        keyY.primaryString = "ᠶ"
        keyY.secondaryString = ""
        keyU.primaryString = "ᠦ"
        keyU.primaryStringDisplayOverride = ""
        keyU.secondaryString = ""
        keyI.primaryString = "ᠢ"
        keyI.secondaryString = ""
        keyO.primaryString = "ᠥ"
        keyO.secondaryString = ""
        keyP.primaryString = "ᠫ"
        keyP.secondaryString = ""
        
        // Row 2
        keyA.primaryString = "ᠠ"
        keyS.primaryString = "ᠰ"
        keyD.primaryString = "ᠳ"
        keyF.primaryString = "ᠹ"
        keyG.primaryString = "ᠭ"
        keyH.primaryString = "ᠬ"
        keyH.secondaryString = "ᠾ"
        keyJ.primaryString = "ᠵ"
        keyJ.secondaryString = "ᡁ"
        keyK.primaryString = "ᠺ"
        keyL.primaryString = "ᠯ"
        keyL.secondaryString = "ᡀ"
        keyNg.primaryString = "ᠩ"
        
        // Row 3
        keyZ.primaryString = "ᠽ"
        keyZ.secondaryString = "ᠼ"
        keyX.primaryString = "ᠱ"
        keyC.primaryString = "ᠣ"
        keyV.primaryString = "ᠤ"
        keyV.primaryStringDisplayOverride = ""
        keyB.primaryString = "ᠪ"
        keyN.primaryString = "ᠨ"
        keyM.primaryString = "ᠮ"
        
    }
    
    func setPunctuationKeyStrings() {
        
        // Row 1
        keyQ.primaryString = "1"
        keyQ.secondaryString = "᠑"
        keyW.primaryString = "2"
        keyW.secondaryString = "᠒"
        keyE.primaryString = "3"
        keyE.secondaryString = "᠓"
        keyR.primaryString = "4"
        keyR.secondaryString = "᠔"
        keyT.primaryString = "5"
        keyT.secondaryString = "᠕"
        keyY.primaryString = "6"
        keyY.secondaryString = "᠖"
        keyU.primaryString = "7"
        keyU.secondaryString = "᠗"
        keyI.primaryString = "8"
        keyI.secondaryString = "᠘"
        keyO.primaryString = "9"
        keyO.secondaryString = "᠙"
        keyP.primaryString = "0"
        keyP.secondaryString = "᠐"
        
        // Row 2
        keyA.primaryString = "("
        keyS.primaryString = ")"
        keyD.primaryString = "<"
        keyF.primaryString = ">"
        keyG.primaryString = "«"
        keyH.primaryString = "»"
        keyH.secondaryString = ""
        keyJ.primaryString = "⁈"
        keyJ.secondaryString = ""
        keyK.primaryString = "⁉"
        keyL.primaryString = "‼"
        keyL.secondaryString = ""
        keyNg.primaryString = "᠄"
        
        // Row 3
        keyZ.primaryString = "᠁"
        keyZ.secondaryString = ""
        keyX.primaryString = "᠅"
        keyC.primaryString = "·"
        keyV.primaryString = "."
        keyB.primaryString = "᠊"
        keyN.primaryString = "︱"
        keyM.primaryString = ";"
    }
    
    
    
    func assignDelegates() {
        
        // Row 1
        keyQ.delegate = self
        keyW.delegate = self
        keyE.delegate = self
        keyR.delegate = self
        keyT.delegate = self
        keyY.delegate = self
        keyU.delegate = self
        keyI.delegate = self
        keyO.delegate = self
        keyP.delegate = self
        
        // Row 2
        keyA.delegate = self
        keyS.delegate = self
        keyD.delegate = self
        keyF.delegate = self
        keyG.delegate = self
        keyH.delegate = self
        keyJ.delegate = self
        keyK.delegate = self
        keyL.delegate = self
        keyNg.delegate = self
        
        // Row 3
        keyFVS.delegate = self
        keyZ.delegate = self
        keyX.delegate = self
        keyC.delegate = self
        keyV.delegate = self
        keyB.delegate = self
        keyN.delegate = self
        keyM.delegate = self
        keyBackspace.delegate = self
        
        // Row 4
        //keyKeyboard.addTarget(self, action: "keyKeyboardTapped", forControlEvents: UIControlEvents.TouchUpInside)
        keyKeyboard.delegate = self
        keyMVS.delegate = self
        keyComma.delegate = self
        keySpace.delegate = self
        keyQuestion.delegate = self
        keySuffix.delegate = self
        keyReturn.addTarget(self, action: "keyReturnTapped", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    override func layoutSubviews() {
        // TODO: - should add autolayout constraints instead
        
        // |   | Q | W | E | R | T | Y | U | I | O | P |    Row 1
        // | b | A | S | D | F | G | H | J | K | L | NG|    Row 2
        // | a | fvs | Z | X | C | V | B | N | M | del |    Row 3
        // | r |1 23 |mvs| , |   space   | ? |nbs| ret |    Row 4
        
        let suggestionBarWidth: CGFloat = 30
        let numberOfRows: CGFloat = 4
        let keyUnitsInRow1: CGFloat = 10
        let rowHeight = self.bounds.height / numberOfRows
        let keyUnitWidth = (self.bounds.width - suggestionBarWidth) / keyUnitsInRow1
        let wideKeyWidth = 1.5 * keyUnitWidth
        let spaceKeyWidth = 3 * keyUnitWidth
        //let row2to5KeyUnitWidth = (self.bounds.width - suggestionBarWidth) / keyUnitsInRow2to5
        
        // Row 1
        
        // Row 1
        keyQ.frame = CGRect(x: suggestionBarWidth + keyUnitWidth*0, y: 0, width: keyUnitWidth, height: rowHeight)
        keyW.frame = CGRect(x: suggestionBarWidth + keyUnitWidth*1, y: 0, width: keyUnitWidth, height: rowHeight)
        keyE.frame = CGRect(x: suggestionBarWidth + keyUnitWidth*2, y: 0, width: keyUnitWidth, height: rowHeight)
        keyR.frame = CGRect(x: suggestionBarWidth + keyUnitWidth*3, y: 0, width: keyUnitWidth, height: rowHeight)
        keyT.frame = CGRect(x: suggestionBarWidth + keyUnitWidth*4, y: 0, width: keyUnitWidth, height: rowHeight)
        keyY.frame = CGRect(x: suggestionBarWidth + keyUnitWidth*5, y: 0, width: keyUnitWidth, height: rowHeight)
        keyU.frame = CGRect(x: suggestionBarWidth + keyUnitWidth*6, y: 0, width: keyUnitWidth, height: rowHeight)
        keyI.frame = CGRect(x: suggestionBarWidth + keyUnitWidth*7, y: 0, width: keyUnitWidth, height: rowHeight)
        keyO.frame = CGRect(x: suggestionBarWidth + keyUnitWidth*8, y: 0, width: keyUnitWidth, height: rowHeight)
        keyP.frame = CGRect(x: suggestionBarWidth + keyUnitWidth*9, y: 0, width: keyUnitWidth, height: rowHeight)
        
        
        
        // Row 2
        
        keyA.frame = CGRect(x: suggestionBarWidth + keyUnitWidth*0, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        keyS.frame = CGRect(x: suggestionBarWidth + keyUnitWidth*1, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        keyD.frame = CGRect(x: suggestionBarWidth + keyUnitWidth*2, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        keyF.frame = CGRect(x: suggestionBarWidth + keyUnitWidth*3, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        keyG.frame = CGRect(x: suggestionBarWidth + keyUnitWidth*4, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        keyH.frame = CGRect(x: suggestionBarWidth + keyUnitWidth*5, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        keyJ.frame = CGRect(x: suggestionBarWidth + keyUnitWidth*6, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        keyK.frame = CGRect(x: suggestionBarWidth + keyUnitWidth*7, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        keyL.frame = CGRect(x: suggestionBarWidth + keyUnitWidth*8, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        keyNg.frame = CGRect(x: suggestionBarWidth + keyUnitWidth*9, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        
        
        
        // Row 3
        
        keyFVS.frame = CGRect(x: suggestionBarWidth, y: rowHeight*2, width: wideKeyWidth, height: rowHeight)
        keyZ.frame = CGRect(x: suggestionBarWidth + wideKeyWidth, y: rowHeight*2, width: keyUnitWidth, height: rowHeight)
        keyX.frame = CGRect(x: suggestionBarWidth + wideKeyWidth + keyUnitWidth*1, y: rowHeight*2, width: keyUnitWidth, height: rowHeight)
        keyC.frame = CGRect(x: suggestionBarWidth + wideKeyWidth + keyUnitWidth*2, y: rowHeight*2, width: keyUnitWidth, height: rowHeight)
        keyV.frame = CGRect(x: suggestionBarWidth + wideKeyWidth + keyUnitWidth*3, y: rowHeight*2, width: keyUnitWidth, height: rowHeight)
        keyB.frame = CGRect(x: suggestionBarWidth + wideKeyWidth + keyUnitWidth*4, y: rowHeight*2, width: keyUnitWidth, height: rowHeight)
        keyN.frame = CGRect(x: suggestionBarWidth + wideKeyWidth + keyUnitWidth*5, y: rowHeight*2, width: keyUnitWidth, height: rowHeight)
        keyM.frame = CGRect(x: suggestionBarWidth + wideKeyWidth + keyUnitWidth*6, y: rowHeight*2, width: keyUnitWidth, height: rowHeight)
        keyBackspace.frame = CGRect(x: suggestionBarWidth + wideKeyWidth + keyUnitWidth*7, y: rowHeight*2, width: wideKeyWidth, height: rowHeight)
        
        // Row 4
        
        keyKeyboard.frame = CGRect(x: suggestionBarWidth, y: rowHeight*3, width: wideKeyWidth, height: rowHeight)
        keyMVS.frame = CGRect(x: suggestionBarWidth + wideKeyWidth, y: rowHeight*3, width: keyUnitWidth, height: rowHeight)
        keyComma.frame = CGRect(x: suggestionBarWidth + wideKeyWidth + keyUnitWidth*1, y: rowHeight*3, width: keyUnitWidth, height: rowHeight)
        keySpace.frame = CGRect(x: suggestionBarWidth + wideKeyWidth + keyUnitWidth*2, y: rowHeight*3, width: spaceKeyWidth, height: rowHeight)
        keyQuestion.frame = CGRect(x: suggestionBarWidth + wideKeyWidth + keyUnitWidth*5, y: rowHeight*3, width: keyUnitWidth, height: rowHeight)
        keySuffix.frame = CGRect(x: suggestionBarWidth + wideKeyWidth + keyUnitWidth*6, y: rowHeight*3, width: keyUnitWidth, height: rowHeight)
        keyReturn.frame = CGRect(x: suggestionBarWidth + wideKeyWidth + keyUnitWidth*7, y: rowHeight*3, width: wideKeyWidth, height: rowHeight)
        
        
    }
    
    // MARK: - Other
    
    func otherAvailableKeyboards(displayNames: [String]) {
        keyKeyboard.menuItems = displayNames
    }
    
    func updateFvsKey(previousChar: String?, currentChar: String) {
        
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
    
    func keyTextEntered(keyText: String) {
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
    
    func keyFvsTapped(fvs: String) {
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
    func keyNewKeyboardChosen(keyboardName: String) {
        delegate?.keyNewKeyboardChosen(keyboardName)
        updateFvsKey("", currentChar: "")
    }
    
}