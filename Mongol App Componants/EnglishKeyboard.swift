import UIKit

class EnglishKeyboard: UIView, KeyboardKeyDelegate {
    
    weak var delegate: KeyboardDelegate? // probably the view controller
    
    //private let renderer = MongolUnicodeRenderer.sharedInstance
    private var punctuationOn = false
    private var shiftOn = false
    
    // Keyboard Keys
    
    // Row 1
    private let keyQ = KeyboardEnglishTextKey()
    private let keyW = KeyboardEnglishTextKey()
    private let keyE = KeyboardEnglishTextKey()
    private let keyR = KeyboardEnglishTextKey()
    private let keyT = KeyboardEnglishTextKey()
    private let keyY = KeyboardEnglishTextKey()
    private let keyU = KeyboardEnglishTextKey()
    private let keyI = KeyboardEnglishTextKey()
    private let keyO = KeyboardEnglishTextKey()
    private let keyP = KeyboardEnglishTextKey()
    
    // Row 2
    private let keyA = KeyboardEnglishTextKey()
    private let keyS = KeyboardEnglishTextKey()
    private let keyD = KeyboardEnglishTextKey()
    private let keyF = KeyboardEnglishTextKey()
    private let keyG = KeyboardEnglishTextKey()
    private let keyH = KeyboardEnglishTextKey()
    private let keyJ = KeyboardEnglishTextKey()
    private let keyK = KeyboardEnglishTextKey()
    private let keyL = KeyboardEnglishTextKey()
    
    // Row 3
    //private let keyFVS = KeyboardFvsKey()
    private let keyShift = KeyboardImageKey()
    private let keyZ = KeyboardEnglishTextKey()
    private let keyX = KeyboardEnglishTextKey()
    private let keyC = KeyboardEnglishTextKey()
    private let keyV = KeyboardEnglishTextKey()
    private let keyB = KeyboardEnglishTextKey()
    private let keyN = KeyboardEnglishTextKey()
    private let keyM = KeyboardEnglishTextKey()
    private let keyBackspace = KeyboardImageKey()
    
    // Row 4
    private let keyKeyboard = KeyboardChooserKey()
    private let keyComma = KeyboardEnglishTextKey()
    private let keySpace = KeyboardImageKey()
    private let keyQuestion = KeyboardEnglishTextKey()
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
        setLowercaseAlphabetKeyStrings()
        assignDelegates()
        
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
        
        // Row 3
        self.addSubview(keyShift)
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
        self.addSubview(keyComma)
        self.addSubview(keySpace)
        self.addSubview(keyQuestion)
        self.addSubview(keyReturn)
        
    }
    
    func initializeNonChangingKeys() {
        
        // Row 3
        keyShift.image = UIImage(named: "shift_dark") // TODO
        keyBackspace.image = UIImage(named: "backspace_dark")
        keyBackspace.keyType = KeyboardImageKey.KeyType.Backspace
        keyBackspace.repeatOnLongPress = true
        
        // Row 4
        keyKeyboard.image = UIImage(named: "keyboard_dark")
        keyComma.primaryString = "."
        keyComma.secondaryString = ","
        keySpace.primaryString = " "
        keySpace.image = UIImage(named: "space_dark")
        keySpace.repeatOnLongPress = true
        keyQuestion.primaryString = "?"
        keyQuestion.secondaryString = "!"
        keyReturn.image = UIImage(named: "return_dark")
    }
    
    func setLowercaseAlphabetKeyStrings() {
        
        // Row 1
        keyQ.primaryString = "q"
        keyW.primaryString = "w"
        keyE.primaryString = "e"
        keyR.primaryString = "r"
        keyT.primaryString = "t"
        keyY.primaryString = "y"
        keyU.primaryString = "u"
        keyI.primaryString = "i"
        keyO.primaryString = "o"
        keyP.primaryString = "p"
        
        // Row 2
        keyA.primaryString = "a"
        keyS.primaryString = "s"
        keyD.primaryString = "d"
        keyF.primaryString = "f"
        keyG.primaryString = "g"
        keyH.primaryString = "h"
        keyJ.primaryString = "j"
        keyK.primaryString = "k"
        keyL.primaryString = "l"
        
        // Row 3
        keyZ.primaryString = "z"
        keyX.primaryString = "x"
        keyC.primaryString = "c"
        keyV.primaryString = "v"
        keyB.primaryString = "b"
        keyN.primaryString = "n"
        keyM.primaryString = "m"
        
    }
    
    func setUppercaseAlphabetKeyStrings() {
        
        // Row 1
        keyQ.primaryString = "Q"
        keyW.primaryString = "W"
        keyE.primaryString = "E"
        keyR.primaryString = "R"
        keyT.primaryString = "T"
        keyY.primaryString = "Y"
        keyU.primaryString = "U"
        keyI.primaryString = "I"
        keyO.primaryString = "O"
        keyP.primaryString = "P"
        
        // Row 2
        keyA.primaryString = "A"
        keyS.primaryString = "S"
        keyD.primaryString = "D"
        keyF.primaryString = "F"
        keyG.primaryString = "G"
        keyH.primaryString = "H"
        keyJ.primaryString = "J"
        keyK.primaryString = "K"
        keyL.primaryString = "L"
        
        // Row 3
        keyZ.primaryString = "Z"
        keyX.primaryString = "X"
        keyC.primaryString = "C"
        keyV.primaryString = "V"
        keyB.primaryString = "B"
        keyN.primaryString = "N"
        keyM.primaryString = "M"
        
    }
    
    func setPunctuationKeyStrings() {
        
        // Row 1
        keyQ.primaryString = "1"
        keyW.primaryString = "2"
        keyE.primaryString = "3"
        keyR.primaryString = "4"
        keyT.primaryString = "5"
        keyY.primaryString = "6"
        keyU.primaryString = "7"
        keyI.primaryString = "8"
        keyO.primaryString = "9"
        keyP.primaryString = "0"
        
        // Row 2
        keyA.primaryString = "("
        keyS.primaryString = ")"
        keyD.primaryString = "+"
        keyF.primaryString = "-"
        keyG.primaryString = "*"
        keyH.primaryString = "/"
        keyJ.primaryString = "="
        keyK.primaryString = "@"
        keyL.primaryString = "%"
        
        // Row 3
        keyZ.primaryString = "#"
        keyX.primaryString = "&"
        keyC.primaryString = ";"
        keyV.primaryString = ":"
        keyB.primaryString = "_"
        keyN.primaryString = "'"
        keyM.primaryString = "\""
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
        
        // Row 3
        keyShift.addTarget(self, action: "keyShiftTapped", forControlEvents: UIControlEvents.TouchUpInside)
        keyZ.delegate = self
        keyX.delegate = self
        keyC.delegate = self
        keyV.delegate = self
        keyB.delegate = self
        keyN.delegate = self
        keyM.delegate = self
        keyBackspace.delegate = self
        
        // Row 4
        keyKeyboard.delegate = self
        keyComma.delegate = self
        keySpace.delegate = self
        keyQuestion.delegate = self
        keyReturn.addTarget(self, action: "keyReturnTapped", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    override func layoutSubviews() {
        // TODO: - should add autolayout constraints instead
        
        // |   | Q | W | E | R | T | Y | U | I | O | P |    Row 1
        // | b | A | S | D | F | G | H | J | K | L | NG|    Row 2
        // | a |shift| Z | X | C | V | B | N | M | del |    Row 3
        // | r |     key | , |      space   | ? | ret  |    Row 4
        
        //let suggestionBarWidth: CGFloat = 30
        let numberOfRows: CGFloat = 4
        let keyUnitsInRow1: CGFloat = 10
        let rowHeight = self.bounds.height / numberOfRows
        let keyUnitWidth = self.bounds.width / keyUnitsInRow1
        let wideKeyWidth = 1.5 * keyUnitWidth
        let spaceKeyWidth = 4 * keyUnitWidth
        //let row2to5KeyUnitWidth = (self.bounds.width - suggestionBarWidth) / keyUnitsInRow2to5
        
        // Row 1
        
        // Row 1
        keyQ.frame = CGRect(x: keyUnitWidth*0, y: 0, width: keyUnitWidth, height: rowHeight)
        keyW.frame = CGRect(x: keyUnitWidth*1, y: 0, width: keyUnitWidth, height: rowHeight)
        keyE.frame = CGRect(x: keyUnitWidth*2, y: 0, width: keyUnitWidth, height: rowHeight)
        keyR.frame = CGRect(x: keyUnitWidth*3, y: 0, width: keyUnitWidth, height: rowHeight)
        keyT.frame = CGRect(x: keyUnitWidth*4, y: 0, width: keyUnitWidth, height: rowHeight)
        keyY.frame = CGRect(x: keyUnitWidth*5, y: 0, width: keyUnitWidth, height: rowHeight)
        keyU.frame = CGRect(x: keyUnitWidth*6, y: 0, width: keyUnitWidth, height: rowHeight)
        keyI.frame = CGRect(x: keyUnitWidth*7, y: 0, width: keyUnitWidth, height: rowHeight)
        keyO.frame = CGRect(x: keyUnitWidth*8, y: 0, width: keyUnitWidth, height: rowHeight)
        keyP.frame = CGRect(x: keyUnitWidth*9, y: 0, width: keyUnitWidth, height: rowHeight)
        
        
        
        // Row 2
        
        keyA.frame = CGRect(x: keyUnitWidth/2 + keyUnitWidth*0, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        keyS.frame = CGRect(x: keyUnitWidth/2 + keyUnitWidth*1, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        keyD.frame = CGRect(x: keyUnitWidth/2 + keyUnitWidth*2, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        keyF.frame = CGRect(x: keyUnitWidth/2 + keyUnitWidth*3, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        keyG.frame = CGRect(x: keyUnitWidth/2 + keyUnitWidth*4, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        keyH.frame = CGRect(x: keyUnitWidth/2 + keyUnitWidth*5, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        keyJ.frame = CGRect(x: keyUnitWidth/2 + keyUnitWidth*6, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        keyK.frame = CGRect(x: keyUnitWidth/2 + keyUnitWidth*7, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        keyL.frame = CGRect(x: keyUnitWidth/2 + keyUnitWidth*8, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        
        
        
        // Row 3
        
        keyShift.frame = CGRect(x: 0, y: rowHeight*2, width: wideKeyWidth, height: rowHeight)
        keyZ.frame = CGRect(x: wideKeyWidth, y: rowHeight*2, width: keyUnitWidth, height: rowHeight)
        keyX.frame = CGRect(x: wideKeyWidth + keyUnitWidth*1, y: rowHeight*2, width: keyUnitWidth, height: rowHeight)
        keyC.frame = CGRect(x: wideKeyWidth + keyUnitWidth*2, y: rowHeight*2, width: keyUnitWidth, height: rowHeight)
        keyV.frame = CGRect(x: wideKeyWidth + keyUnitWidth*3, y: rowHeight*2, width: keyUnitWidth, height: rowHeight)
        keyB.frame = CGRect(x: wideKeyWidth + keyUnitWidth*4, y: rowHeight*2, width: keyUnitWidth, height: rowHeight)
        keyN.frame = CGRect(x: wideKeyWidth + keyUnitWidth*5, y: rowHeight*2, width: keyUnitWidth, height: rowHeight)
        keyM.frame = CGRect(x: wideKeyWidth + keyUnitWidth*6, y: rowHeight*2, width: keyUnitWidth, height: rowHeight)
        keyBackspace.frame = CGRect(x: wideKeyWidth + keyUnitWidth*7, y: rowHeight*2, width: wideKeyWidth, height: rowHeight)
        
        // Row 4
        
        keyKeyboard.frame = CGRect(x: 0, y: rowHeight*3, width: wideKeyWidth, height: rowHeight)
        keyComma.frame = CGRect(x: wideKeyWidth, y: rowHeight*3, width: wideKeyWidth, height: rowHeight)
        keySpace.frame = CGRect(x: wideKeyWidth*2, y: rowHeight*3, width: spaceKeyWidth, height: rowHeight)
        keyQuestion.frame = CGRect(x: wideKeyWidth*2 + spaceKeyWidth, y: rowHeight*3, width: wideKeyWidth, height: rowHeight)
        keyReturn.frame = CGRect(x: wideKeyWidth*3 + spaceKeyWidth, y: rowHeight*3, width: wideKeyWidth, height: rowHeight)
        
        
    }
    
    // MARK: - Other
    
    func otherAvailableKeyboards(displayNames: [String]) {
        keyKeyboard.menuItems = displayNames
    }
    
    // MARK: - KeyboardKeyDelegate protocol
    
    func keyTextEntered(keyText: String) {
        print("key text: \(keyText)")
        
        if shiftOn {
            shiftOn = false
            setLowercaseAlphabetKeyStrings()
        }
        
        // pass the input up to the Keyboard delegate
        self.delegate?.keyWasTapped(keyText)
    }
    
    func keyBackspaceTapped() {
        self.delegate?.keyBackspace()
        print("key text: backspace")
    }
    
    func keyReturnTapped() {
        self.delegate?.keyWasTapped("\n")
        print("key text: return")
    }
    
    func keyFvsTapped(fvs: String) {
        // only here to conform to protocol
    }
    
    func keyShiftTapped() {
        print("key text: shift")
        
        if punctuationOn { return }
        
        shiftOn = !shiftOn
        
        if shiftOn {
            setUppercaseAlphabetKeyStrings()
        } else {
            setLowercaseAlphabetKeyStrings()
        }
    }
    
    func keyKeyboardTapped() {
        print("key text: keyboard")
        
        // switch punctuation
        punctuationOn = !punctuationOn
        shiftOn = false
        
        if punctuationOn {
            setPunctuationKeyStrings()
        } else {
            shiftOn = false
            setLowercaseAlphabetKeyStrings()
        }
        
    }
    
    // tell the view controller to switch keyboards
    func keyNewKeyboardChosen(keyboardName: String) {
        delegate?.keyNewKeyboardChosen(keyboardName)
    }
    
}