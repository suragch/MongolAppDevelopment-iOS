//
//  MainViewController.swift
//  Mongol App Componants
//
//  Created by MongolSuragch on 8/10/15.
//  Copyright © 2015 MongolSuragch. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBAction func alertControllerButton(sender: AnyObject) {
        self.performSegueWithIdentifier("alertDemo", sender: nil)
    }
    @IBAction func buttonButton(sender: AnyObject) {
        self.performSegueWithIdentifier("buttonDemo", sender: nil)
    }
    @IBAction func labelButton(sender: AnyObject) {
        self.performSegueWithIdentifier("labelDemo", sender: nil)
    }
    @IBAction func textViewButton(sender: AnyObject) {
        self.performSegueWithIdentifier("textViewDemo", sender: nil)
    }
    @IBAction func tableViewButton(sender: AnyObject) {
        self.performSegueWithIdentifier("tableViewDemo", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
