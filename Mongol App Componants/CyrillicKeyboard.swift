import UIKit

class CyrillicKeyboard: UIView, KeyboardKeyDelegate {
    
    weak var delegate: KeyboardDelegate? // probably the view controller
    
    //private let renderer = MongolUnicodeRenderer.sharedInstance
    private var punctuationOn = false
    private var shiftOn = false
    
    // Keyboard Keys
    
    // Row 1
    private let key11 = KeyboardEnglishTextKey()
    private let key12 = KeyboardEnglishTextKey()
    private let key13 = KeyboardEnglishTextKey()
    private let key14 = KeyboardEnglishTextKey()
    private let key15 = KeyboardEnglishTextKey()
    private let key16 = KeyboardEnglishTextKey()
    private let key17 = KeyboardEnglishTextKey()
    private let key18 = KeyboardEnglishTextKey()
    private let key19 = KeyboardEnglishTextKey()
    private let key110 = KeyboardEnglishTextKey()
    private let key111 = KeyboardEnglishTextKey()
    private let key112 = KeyboardEnglishTextKey()
    
    // Row 2
    private let key21 = KeyboardEnglishTextKey()
    private let key22 = KeyboardEnglishTextKey()
    private let key23 = KeyboardEnglishTextKey()
    private let key24 = KeyboardEnglishTextKey()
    private let key25 = KeyboardEnglishTextKey()
    private let key26 = KeyboardEnglishTextKey()
    private let key27 = KeyboardEnglishTextKey()
    private let key28 = KeyboardEnglishTextKey()
    private let key29 = KeyboardEnglishTextKey()
    private let key210 = KeyboardEnglishTextKey()
    private let key211 = KeyboardEnglishTextKey()
    private let key212 = KeyboardEnglishTextKey()
    
    // Row 3
    //private let keyFVS = KeyboardFvsKey()
    private let keyShift = KeyboardImageKey()
    private let key31 = KeyboardEnglishTextKey()
    private let key32 = KeyboardEnglishTextKey()
    private let key33 = KeyboardEnglishTextKey()
    private let key34 = KeyboardEnglishTextKey()
    private let key35 = KeyboardEnglishTextKey()
    private let key36 = KeyboardEnglishTextKey()
    private let key37 = KeyboardEnglishTextKey()
    private let key38 = KeyboardEnglishTextKey()
    private let key39 = KeyboardEnglishTextKey()
    private let keyBackspace = KeyboardImageKey()
    
    // Row 4
    private let keyKeyboard = KeyboardChooserKey()
    private let keyComma = KeyboardEnglishTextKey()
    private let keySpace = KeyboardImageKey()
    private let keyQuestion = KeyboardEnglishTextKey()
    private let key41 = KeyboardEnglishTextKey()
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
        self.addSubview(key11)
        self.addSubview(key12)
        self.addSubview(key13)
        self.addSubview(key14)
        self.addSubview(key15)
        self.addSubview(key16)
        self.addSubview(key17)
        self.addSubview(key18)
        self.addSubview(key19)
        self.addSubview(key110)
        self.addSubview(key111)
        self.addSubview(key112)
        
        // Row 2
        self.addSubview(key21)
        self.addSubview(key22)
        self.addSubview(key23)
        self.addSubview(key24)
        self.addSubview(key25)
        self.addSubview(key26)
        self.addSubview(key27)
        self.addSubview(key28)
        self.addSubview(key29)
        self.addSubview(key210)
        self.addSubview(key211)
        self.addSubview(key212)
        
        // Row 3
        self.addSubview(keyShift)
        self.addSubview(key31)
        self.addSubview(key32)
        self.addSubview(key33)
        self.addSubview(key34)
        self.addSubview(key35)
        self.addSubview(key36)
        self.addSubview(key37)
        self.addSubview(key38)
        self.addSubview(key39)
        self.addSubview(keyBackspace)
        
        // Row 4
        self.addSubview(keyKeyboard)
        self.addSubview(keyComma)
        self.addSubview(keySpace)
        self.addSubview(keyQuestion)
        self.addSubview(key41)
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
        key11.primaryString = "ф"
        key12.primaryString = "ц"
        key13.primaryString = "у"
        key14.primaryString = "ж"
        key15.primaryString = "э"
        key16.primaryString = "н"
        key17.primaryString = "г"
        key18.primaryString = "ш"
        key19.primaryString = "ү"
        key110.primaryString = "з"
        key111.primaryString = "к"
        key112.primaryString = "ъ"
        
        
        // Row 2
        key21.primaryString = "й"
        key22.primaryString = "ы"
        key23.primaryString = "б"
        key24.primaryString = "ө"
        key25.primaryString = "а"
        key26.primaryString = "х"
        key27.primaryString = "р"
        key28.primaryString = "о"
        key29.primaryString = "л"
        key210.primaryString = "д"
        key211.primaryString = "п"
        key212.primaryString = "е"
        
        // Row 3
        key31.primaryString = "я"
        key32.primaryString = "ч"
        key33.primaryString = "ё"
        key34.primaryString = "с"
        key35.primaryString = "м"
        key36.primaryString = "и"
        key37.primaryString = "т"
        key38.primaryString = "ь"
        key39.primaryString = "в"
        
        // Row 4
        key41.primaryString = "ю"
        
    }
    
    func setUppercaseAlphabetKeyStrings() {
        
        // Row 1
        key11.primaryString = "Ф"
        key12.primaryString = "Ц"
        key13.primaryString = "У"
        key14.primaryString = "Ж"
        key15.primaryString = "Э"
        key16.primaryString = "Н"
        key17.primaryString = "Г"
        key18.primaryString = "Ш"
        key19.primaryString = "Ү"
        key110.primaryString = "З"
        key111.primaryString = "К"
        key112.primaryString = "Ъ"
        
        
        // Row 2
        key21.primaryString = "Й"
        key22.primaryString = "Ы"
        key23.primaryString = "Б"
        key24.primaryString = "Ө"
        key25.primaryString = "А"
        key26.primaryString = "Х"
        key27.primaryString = "Р"
        key28.primaryString = "О"
        key29.primaryString = "Л"
        key210.primaryString = "Д"
        key211.primaryString = "П"
        key212.primaryString = "Е"
        
        // Row 3
        key31.primaryString = "Я"
        key32.primaryString = "Ч"
        key33.primaryString = "Ё"
        key34.primaryString = "С"
        key35.primaryString = "М"
        key36.primaryString = "И"
        key37.primaryString = "Т"
        key38.primaryString = "Ь"
        key39.primaryString = "В"
        
        // Row 4
        key41.primaryString = "Ю"
        
    }
    
    func setPunctuationKeyStrings() {
        
        // Row 1
        key11.primaryString = "1"
        key12.primaryString = "2"
        key13.primaryString = "3"
        key14.primaryString = "4"
        key15.primaryString = "5"
        key16.primaryString = "6"
        key17.primaryString = "7"
        key18.primaryString = "8"
        key19.primaryString = "9"
        key110.primaryString = "0"
        key111.primaryString = "~"
        key112.primaryString = "$"
        
        // Row 2
        key21.primaryString = "("
        key22.primaryString = ")"
        key23.primaryString = "["
        key24.primaryString = "]"
        key25.primaryString = "^"
        key26.primaryString = "+"
        key27.primaryString = "-"
        key28.primaryString = "*"
        key29.primaryString = "/"
        key210.primaryString = "="
        key211.primaryString = "@"
        key212.primaryString = "%"
        
        // Row 3
        key31.primaryString = "#"
        key32.primaryString = "&"
        key33.primaryString = ";"
        key34.primaryString = ":"
        key35.primaryString = "_"
        key36.primaryString = "'"
        key37.primaryString = "\""
        key38.primaryString = "\\"
        key39.primaryString = "!"
        
        // Row 4
        key41.primaryString = ","
    }
    
    
    
    func assignDelegates() {
        
        // Row 1
        key11.delegate = self
        key12.delegate = self
        key13.delegate = self
        key14.delegate = self
        key15.delegate = self
        key16.delegate = self
        key17.delegate = self
        key18.delegate = self
        key19.delegate = self
        key110.delegate = self
        key111.delegate = self
        key112.delegate = self
        
        // Row 2
        key21.delegate = self
        key22.delegate = self
        key23.delegate = self
        key24.delegate = self
        key25.delegate = self
        key26.delegate = self
        key27.delegate = self
        key28.delegate = self
        key29.delegate = self
        key210.delegate = self
        key211.delegate = self
        key212.delegate = self
        
        // Row 3
        keyShift.addTarget(self, action: "keyShiftTapped", forControlEvents: UIControlEvents.TouchUpInside)
        key31.delegate = self
        key32.delegate = self
        key33.delegate = self
        key34.delegate = self
        key35.delegate = self
        key36.delegate = self
        key37.delegate = self
        key38.delegate = self
        key39.delegate = self
        keyBackspace.delegate = self
        
        // Row 4
        keyKeyboard.delegate = self
        keyComma.delegate = self
        keySpace.delegate = self
        keyQuestion.delegate = self
        key41.delegate = self
        keyReturn.addTarget(self, action: "keyReturnTapped", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    override func layoutSubviews() {
        // TODO: - should add autolayout constraints instead
        
        // |   | ф | ц | у | ж | э | н | г | ш | ү | з | к | ъ |    Row 1
        // |   | й | ы | б | ө | а | х | р | о | л | д | п | е |    Row 2
        // |   |shift| я | ч | ё | с | м | и | т | ь | в | del |    Row 3
        // |   |     key | , |      space     | . | ю |   ret  |    Row 4
        
        //let suggestionBarWidth: CGFloat = 30
        let numberOfRows: CGFloat = 4
        let keyUnitsInRow1: CGFloat = 12
        let rowHeight = self.bounds.height / numberOfRows
        let keyUnitWidth = self.bounds.width / keyUnitsInRow1
        let wideKeyWidth = 1.5 * keyUnitWidth
        let spaceKeyWidth = 5 * keyUnitWidth
        
        // Row 1
        key11.frame = CGRect(x: keyUnitWidth*0, y: 0, width: keyUnitWidth, height: rowHeight)
        key12.frame = CGRect(x: keyUnitWidth*1, y: 0, width: keyUnitWidth, height: rowHeight)
        key13.frame = CGRect(x: keyUnitWidth*2, y: 0, width: keyUnitWidth, height: rowHeight)
        key14.frame = CGRect(x: keyUnitWidth*3, y: 0, width: keyUnitWidth, height: rowHeight)
        key15.frame = CGRect(x: keyUnitWidth*4, y: 0, width: keyUnitWidth, height: rowHeight)
        key16.frame = CGRect(x: keyUnitWidth*5, y: 0, width: keyUnitWidth, height: rowHeight)
        key17.frame = CGRect(x: keyUnitWidth*6, y: 0, width: keyUnitWidth, height: rowHeight)
        key18.frame = CGRect(x: keyUnitWidth*7, y: 0, width: keyUnitWidth, height: rowHeight)
        key19.frame = CGRect(x: keyUnitWidth*8, y: 0, width: keyUnitWidth, height: rowHeight)
        key110.frame = CGRect(x: keyUnitWidth*9, y: 0, width: keyUnitWidth, height: rowHeight)
        key111.frame = CGRect(x: keyUnitWidth*10, y: 0, width: keyUnitWidth, height: rowHeight)
        key112.frame = CGRect(x: keyUnitWidth*11, y: 0, width: keyUnitWidth, height: rowHeight)
        
        
        
        // Row 2
        key21.frame = CGRect(x: keyUnitWidth*0, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        key22.frame = CGRect(x: keyUnitWidth*1, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        key23.frame = CGRect(x: keyUnitWidth*2, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        key24.frame = CGRect(x: keyUnitWidth*3, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        key25.frame = CGRect(x: keyUnitWidth*4, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        key26.frame = CGRect(x: keyUnitWidth*5, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        key27.frame = CGRect(x: keyUnitWidth*6, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        key28.frame = CGRect(x: keyUnitWidth*7, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        key29.frame = CGRect(x: keyUnitWidth*8, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        key210.frame = CGRect(x: keyUnitWidth*9, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        key211.frame = CGRect(x: keyUnitWidth*10, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        key212.frame = CGRect(x: keyUnitWidth*11, y: rowHeight, width: keyUnitWidth, height: rowHeight)
        
        // Row 3
        
        keyShift.frame = CGRect(x: 0, y: rowHeight*2, width: wideKeyWidth, height: rowHeight)
        key31.frame = CGRect(x: wideKeyWidth, y: rowHeight*2, width: keyUnitWidth, height: rowHeight)
        key32.frame = CGRect(x: wideKeyWidth + keyUnitWidth*1, y: rowHeight*2, width: keyUnitWidth, height: rowHeight)
        key33.frame = CGRect(x: wideKeyWidth + keyUnitWidth*2, y: rowHeight*2, width: keyUnitWidth, height: rowHeight)
        key34.frame = CGRect(x: wideKeyWidth + keyUnitWidth*3, y: rowHeight*2, width: keyUnitWidth, height: rowHeight)
        key35.frame = CGRect(x: wideKeyWidth + keyUnitWidth*4, y: rowHeight*2, width: keyUnitWidth, height: rowHeight)
        key36.frame = CGRect(x: wideKeyWidth + keyUnitWidth*5, y: rowHeight*2, width: keyUnitWidth, height: rowHeight)
        key37.frame = CGRect(x: wideKeyWidth + keyUnitWidth*6, y: rowHeight*2, width: keyUnitWidth, height: rowHeight)
        key38.frame = CGRect(x: wideKeyWidth + keyUnitWidth*7, y: rowHeight*2, width: keyUnitWidth, height: rowHeight)
        key39.frame = CGRect(x: wideKeyWidth + keyUnitWidth*8, y: rowHeight*2, width: keyUnitWidth, height: rowHeight)
        keyBackspace.frame = CGRect(x: wideKeyWidth + keyUnitWidth*9, y: rowHeight*2, width: wideKeyWidth, height: rowHeight)
        
        // Row 4
        
        keyKeyboard.frame = CGRect(x: 0, y: rowHeight*3, width: wideKeyWidth, height: rowHeight)
        keyComma.frame = CGRect(x: wideKeyWidth, y: rowHeight*3, width: wideKeyWidth, height: rowHeight)
        keySpace.frame = CGRect(x: wideKeyWidth*2, y: rowHeight*3, width: spaceKeyWidth, height: rowHeight)
        keyQuestion.frame = CGRect(x: wideKeyWidth*2 + spaceKeyWidth, y: rowHeight*3, width: wideKeyWidth, height: rowHeight)
        key41.frame = CGRect(x: wideKeyWidth*3 + spaceKeyWidth, y: rowHeight*3, width: keyUnitWidth, height: rowHeight)
        keyReturn.frame = CGRect(x: wideKeyWidth*3 + spaceKeyWidth + keyUnitWidth, y: rowHeight*3, width: wideKeyWidth, height: rowHeight)
        
        
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