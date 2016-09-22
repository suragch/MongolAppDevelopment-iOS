// UIMongolTextView
// version 1.0


import UIKit

class UITextViewWithoutMenu: UITextView {
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        return false
    }
}


@IBDesignable class UIMongolTextView: UIView {
    
    // FIXME: long load time
    
    // MARK:- Unique to TextView
    
    // ********* Unique to TextView *********
    fileprivate var view = UITextViewWithoutMenu()
    fileprivate let rotationView = UIView()
    fileprivate var userInteractionEnabledForSubviews = true
    fileprivate let mongolFontName = "ChimeeWhiteMirrored"
    fileprivate let defaultFontSize: CGFloat = 17
    fileprivate let mongolTextStorage = MongolTextStorage()
    
    @IBInspectable var text: String {
        get {
            //return view.text
            return mongolTextStorage.unicode
        }
        set {
            mongolTextStorage.unicode = newValue
            view.text = mongolTextStorage.render()
            //view.text = newValue
        }
    }
    
    @IBInspectable var fontSize: CGFloat {
        get {
            if let font = view.font {
                return font.pointSize
            } else {
                return 0.0
            }
        }
        set {
            view.font = UIFont(name: mongolFontName, size: newValue)
        }
    }
    
    @IBInspectable var textColor: UIColor {
        get {
            if let color = view.textColor {
                return color
            } else {
                return UIColor.black
            }
        }
        set {
            view.textColor = newValue
        }
    }
    
    @IBInspectable var centerText: Bool {
        get {
            return view.textAlignment == NSTextAlignment.center
        }
        set {
            if newValue {
                view.textAlignment = NSTextAlignment.center
            }
        }
    }
    
    @IBInspectable var editable: Bool {
        get {
            return view.isEditable
        }
        set {
            view.isEditable = newValue
        }
    }
    
    @IBInspectable var selectable: Bool {
        get {
            return view.isSelectable
        }
        set {
            view.isSelectable = newValue
        }
    }
    
    var scrollEnabled: Bool {
        get {
            return view.isScrollEnabled
        }
        set {
            view.isScrollEnabled = newValue
        }
    }
    
    var attributedText: NSAttributedString! {
        get {
            return view.attributedText
        }
        set {
            view.attributedText = newValue
        }
    }
    
    var contentSize: CGSize {
        get {
            return CGSize(width: view.contentSize.height, height: view.contentSize.width)
        }
        set {
            view.contentSize = CGSize(width: newValue.height, height: newValue.width)
        }
    }
    
    
    
    var underlyingTextView: UITextViewWithoutMenu {
        get {
            return view
        }
        set {
            view = newValue
        }
    }
    
    // TODO: Switch the sides to account for rotation
    var textContainerInset: UIEdgeInsets {
        get {
            return view.textContainerInset
        }
        set {
            view.textContainerInset = newValue
        }
    }
    
    override var intrinsicContentSize : CGSize {
        return CGSize(width: view.frame.height, height: view.frame.width)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        // swap the length and width coming in and going out
        let fitSize = view.sizeThatFits(CGSize(width: size.height, height: size.width))
        return CGSize(width: fitSize.height, height: fitSize.width)
    }
    
    func selectedText() -> String? {
        
        // TODO: this could give error if selected range has emoji
        
        // get the current selected range / cursor position
        guard let selection = view.selectedTextRange else {
            return nil
        }
        
        // get caret or selected range
        // "view.selectedRange" may be easier but use method below as a first step for future emoji support
        let startGlyphIndex = view.offset(from: view.beginningOfDocument, to: selection.start)
        let length = view.offset(from: selection.start, to: selection.end)
        let selectedRange = NSRange(location: startGlyphIndex, length: length)
        
        // insert or replace selection with unicode
        return mongolTextStorage.unicodeForGlyphRange(selectedRange)
    }
    
    func insertMongolText(_ unicode: String) {
        
        // get the current selected range / cursor position
        // TODO: this could give error if selected range has emoji
        if let selection = view.selectedTextRange {
            
            // get caret or selected range
            // "view.selectedRange" may be easier but use method below as a first step for future emoji support
            let startGlyphIndex = view.offset(from: view.beginningOfDocument, to: selection.start)
            let length = view.offset(from: selection.start, to: selection.end)
            let selectedRange = NSRange(location: startGlyphIndex, length: length)
            
            // insert or replace selection with unicode
            mongolTextStorage.insertUnicodeForGlyphRange(selectedRange, unicodeToInsert: unicode)
            
            // render unicode again
            // FIXME: It is inefficient and unnesessary to render everything
            view.text = mongolTextStorage.render()
            
            // set caret position
            if let newPosition = view.position(from: view.beginningOfDocument, in: UITextLayoutDirection.right, offset: mongolTextStorage.glyphIndexForCursor) {
                
                view.selectedTextRange = view.textRange(from: newPosition, to: newPosition)
            }
        }
        
    }
    
    func replaceWordAtCursorWith(_ replacementString: String) {
        // get the cursor position
        if let cursorRange = view.selectedTextRange {
            let cursorPosition = view.offset(from: view.beginningOfDocument, to: cursorRange.start)
            mongolTextStorage.replaceWordAtCursorWith(replacementString, atGlyphIndex: cursorPosition)
            // render unicode again
            // FIXME: It is inefficient and unnesessary to render everything
            view.text = mongolTextStorage.render()
            
            // set caret position
            if let newPosition = view.position(from: view.beginningOfDocument, in: UITextLayoutDirection.right, offset: mongolTextStorage.glyphIndexForCursor) {
                
                view.selectedTextRange = view.textRange(from: newPosition, to: newPosition)
            }
        }
    }
    
    func deleteBackward() {
        
        // get the current selected range / cursor position
        // TODO: this could give error if selected range has emoji
        if let selection = view.selectedTextRange {
            
            // get caret or selected range
            // "view.selectedRange" may be easier but use method below as a first step for future emoji support
            let startGlyphIndex = view.offset(from: view.beginningOfDocument, to: selection.start)
            let length = view.offset(from: selection.start, to: selection.end)
            let selectedRange = NSRange(location: startGlyphIndex, length: length)
            
            // delete unicode backward
            mongolTextStorage.deleteBackwardsAtGlyphRange(selectedRange)
            
            
            // render unicode again
            // FIXME: It is inefficient and unnesessary to render everything
            view.text = mongolTextStorage.render()
            
            // set caret position
            if let newPosition = view.position(from: view.beginningOfDocument, in: UITextLayoutDirection.right, offset: mongolTextStorage.glyphIndexForCursor) {
                
                view.selectedTextRange = view.textRange(from: newPosition, to: newPosition)
            }
        }
    }
    
    func unicodeCharBeforeCursor() -> String? {
        
        // get the cursor position
        if let cursorRange = view.selectedTextRange {
            
            let cursorPosition = view.offset(from: view.beginningOfDocument, to: cursorRange.start)
            return mongolTextStorage.unicodeCharBeforeCursor(cursorPosition)
        }
        return nil
    }
    
    func oneMongolWordBeforeCursor() -> String? {
        // get the cursor position
        if let cursorRange = view.selectedTextRange {
            let cursorPosition = view.offset(from: view.beginningOfDocument, to: cursorRange.start)
            return mongolTextStorage.unicodeOneWordBeforeCursor(cursorPosition)
        }
        return nil
    }
    
    func twoMongolWordsBeforeCursor() -> (String?, String?) {
        // get the cursor position
        if let cursorRange = view.selectedTextRange {
            
            let cursorPosition = view.offset(from: view.beginningOfDocument, to: cursorRange.start)
            return mongolTextStorage.unicodeTwoWordsBeforeCursor(cursorPosition)
        }
        return (nil, nil)
    }
    
    
    
    func setup() {
        // 1-10: ᠨᠢᠭᠡ ᠬᠤᠶᠠᠷ ᠭᠤᠷᠪᠠ ᠳᠦᠷᠪᠡ ᠲᠠᠪᠤ ᠵᠢᠷᠭᠤᠭ᠎ᠠ ᠳᠤᠯᠤᠭ᠎ᠠ ᠨᠠᠢ᠌ᠮᠠ ᠶᠢᠰᠦ ᠠᠷᠪᠠ
        
        // FIXME: UI related settings should go in LayoutSubviews
        //view.backgroundColor = UIColor.yellowColor()
        rotationView.isUserInteractionEnabled = userInteractionEnabledForSubviews
        
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.addSubview(rotationView)
        rotationView.addSubview(view)
        
        // add constraints to pin TextView to rotation view edges.
        let leadingConstraint = NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: rotationView, attribute: NSLayoutAttribute.leading, multiplier: 1.0, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: rotationView, attribute: NSLayoutAttribute.trailing, multiplier: 1.0, constant: 0)
        let topConstraint = NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: rotationView, attribute: NSLayoutAttribute.top, multiplier: 1.0, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: self.view, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: rotationView, attribute: NSLayoutAttribute.bottom, multiplier: 1.0, constant: 0)
        rotationView.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        
        // set font if user didn't specify size in IB
        if self.view.font?.fontName != mongolFontName {
            
            view.font = UIFont(name: mongolFontName, size: defaultFontSize)
        }
        
    }
    
    
    // MARK:- General code for Mongol views
    
    // *******************************************
    // ****** General code for Mongol views ******
    // *******************************************
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rotationView.transform = CGAffineTransform.identity
        rotationView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: self.bounds.height, height: self.bounds.width))
        rotationView.transform = translateRotateFlip()
        
        if self.view.text.isEmpty == false {
            self.view.scrollRangeToVisible(NSMakeRange(0, 1))
        }
        
        // could do this instead of using constraints
        //view.frame = rotationView.bounds
        
    }
    
    func translateRotateFlip() -> CGAffineTransform {
        
        var transform = CGAffineTransform.identity
        
        // translate to new center
        transform = transform.translatedBy(x: (self.bounds.width / 2)-(self.bounds.height / 2), y: (self.bounds.height / 2)-(self.bounds.width / 2))
        // rotate counterclockwise around center
        transform = transform.rotated(by: CGFloat(-M_PI_2))
        // flip vertically
        transform = transform.scaledBy(x: -1, y: 1)
        
        return transform
    }
    
}
