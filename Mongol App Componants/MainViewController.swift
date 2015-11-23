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
    
}
