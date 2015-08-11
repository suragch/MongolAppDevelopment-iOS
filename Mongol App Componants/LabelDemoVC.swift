//
//  LabelDemoVC.swift
//  Mongol App Componants
//
//  Created by MongolSuragch on 7/17/15.
//  Copyright (c) 2015 MongolSuragch. All rights reserved.
//

import UIKit

class LabelDemoVC: UIViewController {

    //@IBOutlet weak var label: UIMongolLabel!
    
    @IBOutlet weak var label2: UIMongolLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let renderer = MongolUnicodeRenderer()
        
        label2.text = renderer.unicodeToGlyphs(label2.text)
        //label2.fontSize = 12
        
    }
    
}
