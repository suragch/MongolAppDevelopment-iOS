import UIKit

extension UIViewController {
    
    func showAlert(withTitle title: String?, message: String?, numberOfButtons: Int, topButtonText: String?, topButtonAction: (()->Void)?, bottomButtonText: String?, bottomButtonAction: (()->Void)?, alertWidth: CGFloat?) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let myAlertController = storyboard.instantiateViewController(withIdentifier: "MongolAlertControllerID") as! UIMongolAlertController
        myAlertController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        myAlertController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        
        
        myAlertController.titleText = title
        myAlertController.messageText = message
        myAlertController.numberOfButtons = numberOfButtons
        myAlertController.alertWidth = alertWidth
        myAlertController.buttonOneText = topButtonText
        myAlertController.buttonTwoText = bottomButtonText
        myAlertController.buttonOneAction = topButtonAction
        myAlertController.buttonTwoAction = bottomButtonAction
        
        self.present(myAlertController, animated: true, completion: nil)
    }
}
