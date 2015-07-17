//
//  File.swift
//  Mongol App Componants
//
//  Created by MongolSuragch on 7/14/15.
//  Copyright (c) 2015 MongolSuragch. All rights reserved.
//

//import Foundation

// This struct is an array of UInt32 to hold Unicode scalar values
struct ScalarString: SequenceType, Hashable, Printable {
    
    private var scalarArray: [UInt32] = []
    
    
    
    init() {
        // does anything need to go here?
    }
    
    init(_ character: UInt32) {
        self.scalarArray.append(character)
    }
    
    init(_ charArray: [UInt32]) {
        for c in charArray {
            self.scalarArray.append(c)
        }
    }
    
    init(_ string: String) {
        
        for s in string.unicodeScalars {
            self.scalarArray.append(s.value)
        }
    }
    
    // Generator in order to conform to SequenceType protocol 
    // (to allow users to iterate as in `for myScalarValue in myScalarString` { ... })
    func generate() -> GeneratorOf<UInt32> {
        
        var nextIndex = 0
        
        return GeneratorOf<UInt32> {
            if (nextIndex > self.scalarArray.count-1) {
                return nil
            }
            return self.scalarArray[nextIndex++]
        }
    }
    
    // append
    mutating func append(scalar: UInt32) {
        self.scalarArray.append(scalar)
    }
    
    mutating func append(scalarString: ScalarString) {
        for scalar in scalarString {
            self.scalarArray.append(scalar)
        }
    }
    
    mutating func append(string: String) {
        for s in string.unicodeScalars {
            self.scalarArray.append(s.value)
        }
    }
    
    // charAt
    func charAt(index: Int) -> UInt32 {
        return self.scalarArray[index]
    }
    
    // clear
    mutating func clear() {
        self.scalarArray.removeAll(keepCapacity: true)
    }
    
    // contains
    func contains(character: UInt32) -> Bool {
        for scalar in self.scalarArray {
            if scalar == character {
                return true
            }
        }
        return false
    }
    
    // description (to implement Printable protocol)
    var description: String {
        
        var string: String = ""
        
        for scalar in scalarArray {
            string.append(UnicodeScalar(scalar))
        }
        return string
    }
    
    // endsWith
    func endsWith() -> UInt32? {
        return self.scalarArray.last
    }
    
    // insert
    mutating func insert(scalar: UInt32, atIndex index: Int) {
        self.scalarArray.insert(scalar, atIndex: index)
    }
       
    // isEmpty
    var isEmpty: Bool {
        get {
            return self.scalarArray.count == 0
        }
    }
    
    // hashValue (to implement Hashable protocol)
    var hashValue: Int {
        get {
            
            // DJB Hash Function
            var hash = 5381
            
            for(var i = 0; i < self.scalarArray.count; i++)
            {
                hash = ((hash << 5) &+ hash) &+ Int(self.scalarArray[i])
            }
            
            return hash
        }
    }
    
    // length
    var length: Int {
        get {
            return self.scalarArray.count
        }
    }
    
    // remove character
    mutating func removeCharAt(index: Int) {
        self.scalarArray.removeAtIndex(index)
    }
    func removingAllInstancesOfChar(character: UInt32) -> ScalarString {
        
        var returnString = ScalarString()
        
        for scalar in self.scalarArray {
            if scalar != character {
                returnString.append(scalar)
            }
        }
        
        return returnString
    }
    
    
    // replace
    func replace(character: UInt32, withChar replacementChar: UInt32) -> ScalarString {
        
        var returnString = ScalarString()
        
        for scalar in self.scalarArray {
            if scalar == character {
                returnString.append(replacementChar)
            } else {
                returnString.append(scalar)
            }
        }
        return returnString
    }
    func replace(character: UInt32, withString replacementString: String) -> ScalarString {
        
        var returnString = ScalarString()
        
        for scalar in self.scalarArray {
            if scalar == character {
                returnString.append(replacementString)
            } else {
                returnString.append(scalar)
            }
        }
        return returnString
    }
    
    // set (an alternative to myScalarString = "some string")
    mutating func set(string: String) {
        self.scalarArray.removeAll(keepCapacity: false)
        for s in string.unicodeScalars {
            self.scalarArray.append(s.value)
        }
    }
    
    // split
    func split(atChar splitChar: UInt32) -> [ScalarString] {
        var partsArray: [ScalarString] = []
        var part: ScalarString = ScalarString()
        for scalar in self.scalarArray {
            if scalar == splitChar {
                partsArray.append(part)
                part = ScalarString()
            } else {
                part.append(scalar)
            }
        }
        partsArray.append(part)
        return partsArray
    }
    
    // startsWith
    func startsWith() -> UInt32? {
        return self.scalarArray.first
    }
    
    // substring
    func substring(startIndex: Int) -> ScalarString {
        // from startIndex to end of string
        var subArray: ScalarString = ScalarString()
        for var i = startIndex; i < self.length; i++ {
            subArray.append(self.scalarArray[i])
        }
        return subArray
    }
    func substring(startIndex: Int, _ endIndex: Int) -> ScalarString {
        // (startIndex is inclusive, endIndex is exclusive)
        var subArray: ScalarString = ScalarString()
        for var i = startIndex; i < endIndex; i++ {
            subArray.append(self.scalarArray[i])
        }
        return subArray
    }
    
    // toString
    func toString() -> String {
        var string: String = ""
        
        for scalar in self.scalarArray {
            string.append(UnicodeScalar(scalar))
        }
        return string
    }
    
    // values
    func values() -> [UInt32] {
        return self.scalarArray
    }
    
}

func ==(left: ScalarString, right: ScalarString) -> Bool {
    return left.hashValue == right.hashValue
}

func +(left: ScalarString, right: ScalarString) -> ScalarString {
    var returnString = ScalarString()
    for scalar in left.values() {
        returnString.append(scalar)
    }
    for scalar in right.values() {
        returnString.append(scalar)
    }
    return returnString
}
