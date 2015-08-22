//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
let sentence = "Line 1\nLine 2\nLine 3\n"
var sentenceLines:[String] = []
sentence.enumerateLines { (line, stop) -> () in
    sentenceLines.append(line)
}
println(sentenceLines)

