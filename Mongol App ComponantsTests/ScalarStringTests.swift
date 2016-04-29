
import XCTest
@testable import Mongol_App_Componants

class ScalarStringTests: XCTestCase {

    
    // MARK: - indexOf
    
    func testIndexOf_zeroLength_nil() {
        
        // Arrange
        let string = ScalarString("abc")
        let emptyString = ScalarString()
        
        // Assert
        XCTAssertEqual(string.indexOf(emptyString), nil)
        XCTAssertEqual(emptyString.indexOf(string), nil)
        XCTAssertEqual(emptyString.indexOf(emptyString), nil)
        
    }
    
    func testIndexOf_singleInLongStringWithManyMatches_firstMatch() {
        
        // Arrange
        let single = ScalarString("c")
        let longString = ScalarString("abcabcabc")
        
        // Act
        let index = longString.indexOf(single)
        
        // Assert
        XCTAssertEqual(index, 2)
        
    }

    func testIndexOf_longInLongStringWithManyMatches_firstMatch() {
        
        // Arrange
        let long = ScalarString("abc")
        let longString = ScalarString("...abc..abc,,,abc")
        
        // Act
        let index = longString.indexOf(long)
        
        // Assert
        XCTAssertEqual(index, 3)
        
    }
    
    func testIndexOf_longStringinShortString_nil() {
        
        // Arrange
        let longString = ScalarString("abcabcabc")
        let shortString = ScalarString("abc")
        
        // Act
        let index = shortString.indexOf(longString)
        
        // Assert
        XCTAssertEqual(index, nil)
        
    }
    
    func testIndexOf_noMatchSingle_nil() {
        
        // Arrange
        let string = ScalarString("123456789qwerty")
        let single = ScalarString("a")
        
        // Act
        let index = string.indexOf(single)
        
        // Assert
        XCTAssertEqual(index, nil)
        
    }
    
    func testIndexOf_noMatchString_nil() {
        
        // Arrange
        let longstring = ScalarString("123456789qwerty")
        let short = ScalarString("abc")
        
        // Act
        let index = longstring.indexOf(short)
        
        // Assert
        XCTAssertEqual(index, nil)
        
    }
    
    func testIndexOf_equalStrings_zero() {
        
        // Arrange
        let longstring = ScalarString("abc")
        let short = ScalarString("abc")
        
        // Act
        let index = longstring.indexOf(short)
        
        // Assert
        XCTAssertEqual(index, 0)
        
    }
    
    // MARK: - insert
    
    func testInsertString_normalConditions_stringWithInsertAtIndex() {
        
        // Arrange
        let originalCopy = ScalarString("0123")
        var mutatingCopy = originalCopy
        let stringToInsert = "abc"
        let index = 2
        
        // Act
        mutatingCopy.insert(stringToInsert, atIndex: index)
        
        // Assert
        XCTAssertEqual(mutatingCopy.toString(), "01abc23")
        
    }
    
    // MARK: - remove
    
    func testRemoveRange_rangeOutOfBounts_nil() {
        
        // Arrange
        let string = ScalarString("abc")
        let range = 4..<9
        
        // Act
        let newString = string.removeRange(range)
        
        // Assert
        XCTAssertEqual(newString, nil)
        
    }
    
    func testRemoveRange_normalRange_shortenedString() {
        
        // Arrange
        let string = ScalarString("This is a test.")
        let range = 4..<9
        
        // Act
        let newString = string.removeRange(range)?.toString()
        let expected = "This test."
        
        // Assert
        XCTAssertEqual(newString, expected)
        
    }
    
    func testRemoveRange_wholeRange_zeroLengthString() {
        
        // Arrange
        let string = ScalarString("abc")
        let range = 0...2
        
        // Act
        let newString = string.removeRange(range)
        let expected = ScalarString()
        
        // Assert
        XCTAssertEqual(newString, expected)
        
    }
    
    // MARK: - replace
    
    func testReplaceRange_normalRange_newString() {
        
        // Arrange
        let string = ScalarString("aabbcc")
        let replacementString = ScalarString("123")
        let range = 2..<4
        
        // Act
        let newString = string.replaceRange(range, withString: replacementString)
        let expected = ScalarString("aa123cc")
        
        // Assert
        XCTAssertEqual(newString, expected)
        
    }
    
    func testReplaceRange_beginningRange_newString() {
        
        // Arrange
        let string = ScalarString("aabbcc")
        let replacementString = ScalarString("123")
        let range = 0..<4
        
        // Act
        let newString = string.replaceRange(range, withString: replacementString)
        let expected = ScalarString("123cc")
        
        // Assert
        XCTAssertEqual(newString, expected)
        
    }
    
    func testReplaceRange_endRange_newString() {
        
        // Arrange
        let string = ScalarString("aabbcc")
        let replacementString = ScalarString("123")
        let range = 2..<6
        
        // Act
        let newString = string.replaceRange(range, withString: replacementString)
        let expected = ScalarString("aa123")
        
        // Assert
        XCTAssertEqual(newString, expected)
        
    }
    
    func testReplaceRange_fullRange_newString() {
        
        // Arrange
        let string = ScalarString("aabbcc")
        let replacementString = ScalarString("123")
        let range = 0..<6
        
        // Act
        let newString = string.replaceRange(range, withString: replacementString)
        let expected = ScalarString("123")
        
        // Assert
        XCTAssertEqual(newString, expected)
        
    }
    
    func testReplaceRange_emptyRange_oldString() {
        
        // Arrange
        let string = ScalarString("aabbcc")
        let replacementString = ScalarString("123")
        let range = 3..<3
        
        // Act
        let newString = string.replaceRange(range, withString: replacementString)
        let expected = ScalarString("aabbcc")
        
        // Assert
        XCTAssertEqual(newString, expected)
        
    }
    
    func testReplaceRange_singleValueRange_newString() {
        
        // Arrange
        let string = ScalarString("aabbcc")
        let replacementString = ScalarString("123")
        let range = 3..<4
        
        // Act
        let newString = string.replaceRange(range, withString: replacementString)
        let expected = ScalarString("aab123cc")
        
        // Assert
        XCTAssertEqual(newString, expected)
        
    }
    
    // MARK: - split
    
    func testSplit_emptyString_emptyArray() {
        
        // Arrange
        let string = ScalarString("")
        let space = ScalarString(" ").charAt(0)
        
        // Act
        let newString = string.split(atChar: space)
        let expected: [ScalarString] = []
        
        // Assert
        XCTAssertEqual(newString, expected)
        
    }
    
    func testSplit_normalString_arrayOfParts() {
        
        // Arrange
        let string = ScalarString("a test.")
        let space = ScalarString(" ").charAt(0)
        
        // Act
        let newString = string.split(atChar: space)
        let expected = [ScalarString("a"), ScalarString("test.")]
        
        // Assert
        XCTAssertEqual(newString, expected)
        
    }
    
    func testSplit_noMatch_arrayOfOne() {
        
        // Arrange
        let string = ScalarString("aTest.")
        let space = ScalarString(" ").charAt(0)
        
        // Act
        let newString = string.split(atChar: space)
        let expected = [ScalarString("aTest.")]
        
        // Assert
        XCTAssertEqual(newString, expected)
        
    }
    
    // MARK: - trim
    
    func testTrim_allWhiteSpace_emptyString() {
        
        // Arrange
        let myString = ScalarString(" \n \t ")
        
        // Act
        let newString = myString.trim()
        
        // Assert
        XCTAssertEqual(newString, ScalarString())
        
    }
    
    func testTrim_emptyString_emptyString() {
        
        // Arrange
        let myString = ScalarString("")
        
        // Act
        let newString = myString.trim()
        
        // Assert
        XCTAssertEqual(newString, ScalarString())
        
    }
    
    func testTrim_normalCase_substring() {
        
        // Arrange
        let myString = ScalarString(" \thello hi \n")
        
        // Act
        let newString = myString.trim()
        
        // Assert
        XCTAssertEqual(newString, ScalarString("hello hi"))
        
    }
    
    func testTrim_singleChar_singleChar() {
        
        // Arrange
        let myString = ScalarString("a")
        
        // Act
        let newString = myString.trim()
        
        // Assert
        XCTAssertEqual(newString, ScalarString("a"))
        
    }
    
    
}
