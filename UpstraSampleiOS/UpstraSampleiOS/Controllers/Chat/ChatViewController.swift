
import UIKit
import UpstraUIKit
class ChatViewController: BaseViewController {
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var txtSearch: UITextField!
    private lazy var chatViewController: EkoChatHomePageViewController = {
          var viewController = EkoChatHomePageViewController.make()
          self.add(containerView: self.viewContainer, asChildViewController: viewController)
          return viewController
      }()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.txtSearch.isHidden = true
        self.add(containerView: self.viewContainer, asChildViewController: chatViewController)

    }

}
