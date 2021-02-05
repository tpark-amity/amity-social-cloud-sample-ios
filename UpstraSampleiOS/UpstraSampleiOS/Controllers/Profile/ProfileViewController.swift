
import UIKit
import UpstraUIKit
class ProfileViewController: BaseViewController {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var btnBack: UIButton!
    var userId = ""
    private lazy var profileViewController: EkoUserProfilePageViewController = {
            var viewController = EkoUserProfilePageViewController.make(withUserId: self.userId)
            self.add(containerView: self.viewContainer, asChildViewController: viewController)
            return viewController
        }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.add(containerView: self.viewContainer, asChildViewController: profileViewController)
    }
    override func viewWillDisappear(_ animated: Bool) {
          super.viewWillDisappear(animated)
      }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
            self.navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func actionBack(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
}
