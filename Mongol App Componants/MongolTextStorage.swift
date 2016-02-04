

import UIKit

class MongolTextStorage {
    
    private var unicodeText = ScalarString()
    private let renderer = MongolUnicodeRenderer.sharedInstance
    private let cursorHolder = MongolUnicodeRenderer.Glyph.CURSOR_HOLDER
    private var unicodeIndexForCursor = 0
    
    // MARK: - public API
    
    var glyphIndexForCursor = 0
    
    var unicode: String {
        return unicodeText.toString()
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
    
    func deleteBackwardsAtGlyphRange(textRange: NSRange) {
        
        // TODO: double delete for FVS, MVS, NNBSP, ZWJ
        
        if textRange.length == 0 { // caret position
            
            // if glyph index has changed, need to update unicode index
            if textRange.location != glyphIndexForCursor {
                glyphIndexForCursor = textRange.location
                unicodeIndexForCursor = renderer.getUnicodeIndex(unicodeText, glyphIndex: glyphIndexForCursor)
            }
            
            if unicodeIndexForCursor > 0 {
                unicodeText.removeCharAt(unicodeIndexForCursor - 1)
                --unicodeIndexForCursor
            }
            
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
            unicodeIndexForCursor = textRange.location
            
        }
        
        // insert new unicode
        unicodeText.insert(newText, atIndex: unicodeIndexForCursor)
        unicodeIndexForCursor += newText.length
 
    }
    
}