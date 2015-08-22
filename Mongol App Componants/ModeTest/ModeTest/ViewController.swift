//
//  ViewController.swift
//  ModeTest
//
//  Created by MongolSuragch on 8/22/15.
//  Copyright © 2015 Suragch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imageView.contentMode = UIViewContentMode.ScaleToFill
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.contentMode = UIViewContentMode.Redraw
        imageView.contentMode = UIViewContentMode.Center
        imageView.contentMode = UIViewContentMode.Top
        imageView.contentMode = UIViewContentMode.Bottom
        imageView.contentMode = UIViewContentMode.Left
        imageView.contentMode = UIViewContentMode.Right
        imageView.contentMode = UIViewContentMode.TopLeft
        imageView.contentMode = UIViewContentMode.TopRight
        imageView.contentMode = UIViewContentMode.BottomLeft
        imageView.contentMode = UIViewContentMode.BottomRight
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

