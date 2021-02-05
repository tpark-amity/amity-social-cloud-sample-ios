
import UIKit
class MoreItemTableViewCell: UITableViewCell {
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSub: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var stackLables: UIStackView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 }
    func configureBookMark(item:MoreItemModel)  {
        self.lblTitle.text = item.title
        self.lblSub.text = item.sub
        self.lblPrice.text = "$"+item.price
        self.lblPrice.isHidden = item.isArticle
        self.stackLables.distribution = item.isArticle ? .fill : .fillEqually
        self.imgItem.imageFromUrl(urlString: item.coverImage)
        self.imgItem.contentMode = .scaleToFill
    }
    func configurePurchase(item:ItemModel)  {
        self.lblTitle.text = item.category
        self.lblSub.text = item.name
        self.lblPrice.text = "$"+item.price
        self.imgItem.imageFromUrl(urlString: item.coverImage)
        self.imgItem.contentMode = .scaleToFill
    }
}
