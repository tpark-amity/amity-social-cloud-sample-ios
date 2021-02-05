
import UIKit
import UpstraUIKit
class GroupViewController: BaseViewController {
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnNewsFeed: UIButton!
    @IBOutlet weak var btnExplore: UIButton!
    @IBOutlet weak var widthBar: NSLayoutConstraint!
    @IBOutlet weak var middleBar: NSLayoutConstraint!
    
    var controller = UIViewController()
    var currentIndex = -1
    private lazy var globalFeedViewController: EkoGlobalFeedViewController = {
        var viewController = EkoGlobalFeedViewController.make()
        self.add(containerView: self.viewContainer, asChildViewController: viewController)
        return viewController
    }()
    private lazy var exploreViewCOntroller: EkoExploreViewController = {
        var viewController = EkoExploreViewController.make()
        self.add(containerView: self.viewContainer, asChildViewController: viewController)
        return viewController
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setContainerView(index: 0)
    }
    @IBAction func actionTab(_ sender:UIButton){
        if sender.tag != self.currentIndex{
        self.setContainerView(index: sender.tag)
        self.animateView(index: sender.tag)
        }
    }
    func setContainerView(index:Int){
        self.currentIndex = index
        if index == 0 {
               remove(asChildViewController: exploreViewCOntroller)
            add(containerView: self.viewContainer, asChildViewController: globalFeedViewController)
           } else {
               remove(asChildViewController: globalFeedViewController)
            add(containerView: self.viewContainer, asChildViewController: exploreViewCOntroller)
           }
    }
    func animateView(index:Int)  {
        GCD.async(.Main) {
            UIView.animate(withDuration: 0.5, animations: {
                self.middleBar.priority = index == 1 ? .defaultLow : .defaultHigh
            }) { (success) in
                self.widthBar.constant = index == 0 ? 107 : 65
            }
        }
    }
}
