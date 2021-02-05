
import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func createAlert(titletext : String, messagetext : String,enableLoop:Bool = false)
    {
        GCD.async(.Main) {
            let alert = UIAlertController(title: titletext, message: "\(messagetext)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
                if enableLoop{
                    self.createAlert(titletext: titletext, messagetext: messagetext,enableLoop: enableLoop)
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showWrongDataAlert() {
        self.createAlert(titletext: "Sorry", messagetext: AppMessages.invalidJsonData,enableLoop: true)
    }
    func add(containerView viewContainer:UIView , asChildViewController viewController: UIViewController) {
        self.addChild(viewController)
        viewContainer.addSubview(viewController.view)
        viewController.view.frame = viewContainer.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
}
