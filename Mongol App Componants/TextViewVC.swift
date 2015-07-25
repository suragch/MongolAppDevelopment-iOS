//
//  TextViewVC.swift
//  Mongol App Componants
//
//  Created by MongolSuragch on 6/20/15.
//  Copyright (c) 2015 MongolSuragch. All rights reserved.
//

import UIKit

class TextViewVC: UIViewController {

    
    @IBOutlet weak var textView: UIMongolTextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //myUITextView.font = UIFont(name: "ChimeeWhiteMirrored", size: myUITextView.font.pointSize)
        //myUITextView.setTheFont("ChimeeWhiteMirrored")
        
        print(textView.text)
        
        print("THis is a test.")
        let renderer = MongolUnicodeRenderer()
        var myString = ScalarString("This is a test.")
        //println(myString.values())
        var myMongolString = renderer.unicodeToGlyphs("Mongol ᠵᠠᠬᠢᠶ᠎ᠠ ᠶᠢ ᠳᠣᠪᠴᠢᠳᠠᠪᠠᠯ")
        print(myMongolString)
        
        textView.text = renderer.unicodeToGlyphs(textView.text)
    }

    
}
