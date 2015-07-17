//
//  UITextView+CustomFont.swift
//  Mongol App Componants
//
//  Created by MongolSuragch on 6/27/15.
//  Copyright (c) 2015 MongolSuragch. All rights reserved.
//

import UIKit

extension UITextView {
    
    // TODO write some help for how and where and why this is used
    
    public var myFontName: String {
        get {
            return self.font!.fontName
        }
        set {
            self.font = UIFont(name: newValue, size: self.font!.pointSize)
        }
    }
    
    func setTheFont(fontName: String) {
        self.font = UIFont(name: fontName, size: self.font!.pointSize)
    }
    
    
}
