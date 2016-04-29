// This struct is an array of UInt32 to hold Unicode scalar values
// Version 3.3.0


struct ScalarString: SequenceType, Hashable, CustomStringConvertible {
    
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
    func generate() -> AnyGenerator<UInt32> {
        return AnyGenerator(scalarArray.generate())
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
    
    // indexOf
    // returns first index of scalar string match
    func indexOf(string: ScalarString) -> Int? {
        
        if scalarArray.count < string.length {
            return nil
        }
        
        for i in 0...(scalarArray.count - string.length) {
            
            for j in 0..<string.length {
                
                if string.charAt(j) != scalarArray[i + j] {
                    break // substring mismatch
                }
                if j == string.length - 1 {
                    return i
                }
            }
        }
        
        return nil
    }
    
    // insert
    mutating func insert(scalar: UInt32, atIndex index: Int) {
        self.scalarArray.insert(scalar, atIndex: index)
    }
    mutating func insert(string: ScalarString, atIndex index: Int) {
        var newIndex = index
        for scalar in string {
            self.scalarArray.insert(scalar, atIndex: newIndex)
            newIndex += 1
        }
    }
    mutating func insert(string: String, atIndex index: Int) {
        var newIndex = index
        for scalar in string.unicodeScalars {
            self.scalarArray.insert(scalar.value, atIndex: newIndex)
            newIndex += 1
        }
    }
    
    // isEmpty
    var isEmpty: Bool {
        return self.scalarArray.count == 0
    }
    
    // hashValue (to implement Hashable protocol)
    var hashValue: Int {
        
        // DJB Hash Function
        return self.scalarArray.reduce(5381) {
            ($0 << 5) &+ $0 &+ Int($1)
        }
    }
    
    // length
    var length: Int {
        return self.scalarArray.count
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
    func removeRange(range: Range<Int>) -> ScalarString? {
        
        if range.startIndex < 0 || range.endIndex > scalarArray.count {
            return nil
        }
        
        var returnString = ScalarString()
        
        for i in 0..<scalarArray.count {
            if i < range.startIndex || i >= range.endIndex {
                returnString.append(scalarArray[i])
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
    func replaceRange(range: Range<Int>, withString replacementString: ScalarString) -> ScalarString {
        
        var returnString = ScalarString()
        
        for i in 0..<scalarArray.count {
            if i < range.startIndex || i >= range.endIndex {
                returnString.append(scalarArray[i])
            } else if i == range.startIndex {
                returnString.append(replacementString)
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
        if self.scalarArray.count == 0 {
            return partsArray
        }
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
        for i in startIndex..<self.length {
            subArray.append(self.scalarArray[i])
        }
        return subArray
    }
    func substring(startIndex: Int, _ endIndex: Int) -> ScalarString {
        // (startIndex is inclusive, endIndex is exclusive)
        var subArray: ScalarString = ScalarString()
        for i in startIndex..<endIndex {
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
    
    // trim
    // removes leading and trailing whitespace (space, tab, newline)
    func trim() -> ScalarString {
        
        //var returnString = ScalarString()
        let space: UInt32 = 0x00000020
        let tab: UInt32 = 0x00000009
        let newline: UInt32 = 0x0000000A
        
        var startIndex = self.scalarArray.count
        var endIndex = 0
        
        // leading whitespace
        for i in 0..<self.scalarArray.count {
            if self.scalarArray[i] != space &&
                self.scalarArray[i] != tab &&
                self.scalarArray[i] != newline {
                
                startIndex = i
                break
            }
        }
        
        // trailing whitespace
        for i in (self.scalarArray.count - 1).stride(through: 0, by: -1) {
            if self.scalarArray[i] != space &&
                self.scalarArray[i] != tab &&
                self.scalarArray[i] != newline {
                
                endIndex = i + 1
                break
            }
        }
        
        if endIndex <= startIndex {
            return ScalarString()
        }
        
        return self.substring(startIndex, endIndex)
    }
    
    // values
    func values() -> [UInt32] {
        return self.scalarArray
    }
    
}

func ==(left: ScalarString, right: ScalarString) -> Bool {
    return left.scalarArray == right.scalarArray
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
