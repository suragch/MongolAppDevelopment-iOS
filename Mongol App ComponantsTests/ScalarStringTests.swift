
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
}
