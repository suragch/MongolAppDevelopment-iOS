// MongolTextStorage
// version 1.0.0



import UIKit

class MongolTextStorage {
    
    private var unicodeText = ScalarString()
    private let renderer = MongolUnicodeRenderer.sharedInstance
    private let cursorHolder = MongolUnicodeRenderer.Glyph.CURSOR_HOLDER
    private var unicodeIndexForCursor = -1
    private let space = ScalarString(" ").charAt(0) // space
    private let questionMark = ScalarString("?").charAt(0)
    private let exclamationPoint = ScalarString("!").charAt(0)
    private let newLine = ScalarString("\n").charAt(0)
    
    // MARK: - public API
    
    var glyphIndexForCursor = -1
    
    var unicode: String {
        get {
            return unicodeText.toString()
        }
        set {
            unicodeText = ScalarString(newValue)
            unicodeIndexForCursor = unicodeText.length
            // TODO: do I need to set the glyph index too?
        }
    }
    
    func render() -> String {
        var tempText = unicodeText
        tempText.insert(cursorHolder, atIndex: unicodeIndexForCursor)
        var renderedText = renderer.unicodeToGlyphs(tempText)
        if let index = renderedText.indexOf(ScalarString(cursorHolder)) {
            renderedText.removeCharAt(index)
            glyphIndexForCursor = index
        }
        return renderedText.toString()
    }
    
    func clear() {
        unicodeText = ScalarString()
        unicodeIndexForCursor = 0
        glyphIndexForCursor = 0
    }
    
    func deleteBackwardsAtGlyphRange(textRange: NSRange) {
        
        // TODO: double delete for FVS, MVS, NNBSP, ZWJ
        
        if textRange.length == 0 { // caret position
            
            // update unicode index
            if textRange.location != glyphIndexForCursor {
                glyphIndexForCursor = textRange.location
                unicodeIndexForCursor = renderer.getUnicodeIndex(unicodeText, glyphIndex: glyphIndexForCursor)
            }
            
            // return if at beginning
            if unicodeIndexForCursor <= 0 {
                return
            }
            
            // delete all invisible formatting characters + one visible char
            var character = UInt32()
            repeat {
                character = unicodeText.charAt(unicodeIndexForCursor - 1)
                unicodeText.removeCharAt(unicodeIndexForCursor - 1)
                unicodeIndexForCursor -= 1
            } while unicodeIndexForCursor > 0 && isFormattingChar(character)
            
        } else { // range of text is selected
            
            // just delete the current range
            
            // get unicode range
            let unicodeStart = renderer.getUnicodeIndex(unicodeText, glyphIndex: textRange.location)
            let unicodeEnd = renderer.getUnicodeIndex(unicodeText, glyphIndex: textRange.location + textRange.length)
            
            // delete range
            if let stringWithoutRange = unicodeText.removeRange(unicodeStart..<unicodeEnd) {
                unicodeText = stringWithoutRange
            }
            unicodeIndexForCursor = textRange.location
        }
        
        
    }
    
    func isFormattingChar(char: UInt32) -> Bool {
        
        return
            char == MongolUnicodeRenderer.Uni.FVS1 ||
                char == MongolUnicodeRenderer.Uni.FVS2 ||
                char == MongolUnicodeRenderer.Uni.FVS3 ||
                char == MongolUnicodeRenderer.Uni.MVS ||
                char == MongolUnicodeRenderer.Uni.ZWJ
    }
    
    func unicodeForGlyphRange(textRange: NSRange) -> String? {
        
        if textRange.length == 0 { // caret position
            
            return nil
            
        } else { // range of text is selected
            
            // get unicode range
            let unicodeStart = renderer.getUnicodeIndex(unicodeText, glyphIndex: textRange.location)
            let unicodeEnd = renderer.getUnicodeIndex(unicodeText, glyphIndex: textRange.location + textRange.length)
            
            return unicodeText.substring(unicodeStart, unicodeEnd).toString()
            
        }
    }
    
    func insertUnicodeForGlyphRange(textRange: NSRange, unicodeToInsert: String) {
        // FIXME: this method assumes no emoji
        let newText = ScalarString(unicodeToInsert)
        
        if textRange.length == 0 { // caret position
            
            // if glyph index has changed, need to update unicode index
            if textRange.location != glyphIndexForCursor {
                glyphIndexForCursor = textRange.location
                unicodeIndexForCursor = renderer.getUnicodeIndex(unicodeText, glyphIndex: glyphIndexForCursor)
            }
            
        } else { // range of text is selected
            
            // get unicode range
            let unicodeStart = renderer.getUnicodeIndex(unicodeText, glyphIndex: textRange.location)
            let unicodeEnd = renderer.getUnicodeIndex(unicodeText, glyphIndex: textRange.location + textRange.length)
            
            // delete range
            if let stringWithoutRange = unicodeText.removeRange(unicodeStart..<unicodeEnd) {
                unicodeText = stringWithoutRange
            }
            unicodeIndexForCursor = unicodeStart
            
        }
        
        // insert new unicode
        unicodeText.insert(newText, atIndex: unicodeIndexForCursor)
        unicodeIndexForCursor += newText.length
        
    }
    
    func replaceWordAtCursorWith(replacementString: String, atGlyphIndex glyphIndex: Int) {
        
        let myReplacementString = ScalarString(replacementString)
        
        // if glyph index has changed, need to update unicode index
        if glyphIndex != glyphIndexForCursor {
            glyphIndexForCursor = glyphIndex
            unicodeIndexForCursor = renderer.getUnicodeIndex(unicodeText, glyphIndex: glyphIndexForCursor)
        }
        
        // get the range of the whole word
        let originalPosition = unicodeIndexForCursor
        
        // get the start index
        var startIndex = originalPosition
        if originalPosition > 0 {
            for i in (originalPosition - 1).stride(through: 0, by: -1) {
                
                if unicodeText.charAt(i) == MongolUnicodeRenderer.Uni.NNBS {
                    // Stop at NNBS.
                    // Consider it part of the suffix
                    // But consider anything before as a separate word
                    startIndex = i
                    break
                } else if renderer.isMongolian(unicodeText.charAt(i)) {
                    startIndex = i
                } else if unicodeText.charAt(i) == space && myReplacementString.charAt(0) == MongolUnicodeRenderer.Uni.NNBS {
                    // allow a single space before the word to be replaced if the replacement word starts with NNBS
                    startIndex = i
                    break
                } else {
                    break
                }
            }
        }
        
        // do a simple insert if not following any Mongol characters
        if startIndex == originalPosition {
            unicodeText.insert(myReplacementString, atIndex: startIndex)
            unicodeIndexForCursor = startIndex + myReplacementString.length
            return
        }
        
        // get the end index
        var endIndex = originalPosition
        for i in originalPosition..<unicodeText.length {
            
            if renderer.isMongolian(unicodeText.charAt(i)) {
                endIndex = i + 1 // end index is exclusive
            } else {
                break
            }
        }
        
        // replace range with new word
        unicodeText = unicodeText.replaceRange(startIndex..<endIndex, withString: myReplacementString)
        unicodeIndexForCursor = startIndex + myReplacementString.length
    }
    
    func unicodeCharBeforeCursor(glyphIndex: Int) -> String? {
        
        // if glyph index has changed, need to update unicode index
        if glyphIndex != glyphIndexForCursor {
            glyphIndexForCursor = glyphIndex
            unicodeIndexForCursor = renderer.getUnicodeIndex(unicodeText, glyphIndex: glyphIndexForCursor)
        }
        
        if unicodeIndexForCursor > 0 {
            return ScalarString(unicodeText.charAt(unicodeIndexForCursor - 1)).toString()
        }
        
        return nil
    }
    
    /// Gets the Mongolian word/characters before the cursor position
    ///
    /// - warning: Only gets called if cursor is adjacent to a Mongolian character
    /// - parameter glyphIndex: glyph index (not unicode index) of the cursor
    /// - returns: an optional string of the Mongolian characters before cursor
    func unicodeOneWordBeforeCursor(glyphIndex: Int) -> String? {
        
        // if glyph index has changed, need to update unicode index
        if glyphIndex != glyphIndexForCursor {
            glyphIndexForCursor = glyphIndex
            unicodeIndexForCursor = renderer.getUnicodeIndex(unicodeText, glyphIndex: glyphIndexForCursor)
        }
        
        let startPosition = unicodeIndexForCursor - 1
        if startPosition < 0 {
            return nil
        }
        if !renderer.isMongolian(unicodeText.charAt(startPosition)) {
            return nil
        }
        
        
        // Get the word
        //var firstWordHasEnded = false // flag if bewteen words, allow single space/NNBS
        var word = ScalarString()
        for i in startPosition.stride(through: 0, by: -1) {
            
            if unicodeText.charAt(i) == MongolUnicodeRenderer.Uni.NNBS {
                // Stop at NNBS.
                // Consider it part of the suffix
                // But consider anything before as a separate word
                word.insert(unicodeText.charAt(i), atIndex: 0)
                break
            } else if renderer.isMongolian(unicodeText.charAt(i)) {
                word.insert(unicodeText.charAt(i), atIndex: 0)
            } else {
                break
            }
        }
        
        return word.toString()
        
    }
    
    /// Gets the two Mongolian words before the cursor position
    ///
    /// - warning: Only gets called if cursor if after a Mongolian character
    /// - parameter glyphIndex: glyph index (not unicode index) of the cursor
    /// - returns: tuple of optional strings: (first word from cursor, second word from cursor)
    func unicodeTwoWordsBeforeCursor(glyphIndex: Int) -> (String?, String?) {
        
        // if glyph index has changed, need to update unicode index
        if glyphIndex != glyphIndexForCursor {
            glyphIndexForCursor = glyphIndex
            unicodeIndexForCursor = renderer.getUnicodeIndex(unicodeText, glyphIndex: glyphIndexForCursor)
        }
        
        let startPosition = unicodeIndexForCursor - 1
        // empty
        if startPosition < 0 {
            return (nil, nil)
        }
        // not mongolian char or nnbs
        if !renderer.isMongolian(unicodeText.charAt(startPosition)) &&
            unicodeText.charAt(startPosition) != MongolUnicodeRenderer.Uni.NNBS {
            return (nil, nil)
        }
        
        
        // Get the words
        var firstWordHasEnded = false // flag if bewteen words, allow single space/NNBS
        var words = ScalarString()
        for i in startPosition.stride(through: 0, by: -1) {
            
            if unicodeText.charAt(i) == MongolUnicodeRenderer.Uni.NNBS {
                // Stop at NNBS.
                // Consider it part of the suffix
                // But consider anything before as a separate word
                words.insert(unicodeText.charAt(i), atIndex: 0)
                if firstWordHasEnded {
                    break
                }
                firstWordHasEnded = true
                words.insert(space, atIndex: 0) // word delimeter is space
            } else if unicodeText.charAt(i) == space {
                // First space is kept as a delimeter between words
                if firstWordHasEnded {
                    break
                }
                firstWordHasEnded = true
                words.insert(unicodeText.charAt(i), atIndex: 0)
            } else if renderer.isMongolian(unicodeText.charAt(i)) {
                words.insert(unicodeText.charAt(i), atIndex: 0)
            } else {
                break
            }
        }
        
        // return (firstWordBackFromCursor, secondWordBackFromCursor)
        
        var wordsArray = words.trim().split(atChar: space)
        if wordsArray.count == 1 {
            return (wordsArray[0].toString(), nil)
        } else if wordsArray.count > 1 {
            return (wordsArray[wordsArray.count - 1].toString(), wordsArray[wordsArray.count - 2].toString())
        } else {
            return (nil, nil)
        }
    }
    
    
    
}