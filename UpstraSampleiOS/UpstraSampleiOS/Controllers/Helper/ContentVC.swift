
import UIKit


class ContentVC: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var pageIndex: Int = 0
    var strTitle: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = strTitle
    }

}
