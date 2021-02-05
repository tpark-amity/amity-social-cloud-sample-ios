
import UIKit
class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblMake: UILabel!
    @IBOutlet weak var lblBrand: UILabel!
    @IBOutlet weak var lblHeadLine: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configure(item:ArticleItemModel)  {
        self.lblBrand.text = item.brand
        self.lblMake.text = item.make
        self.lblHeadLine.text = item.headline
        self.imgItem.imageFromUrl(urlString: item.coverImage)
        self.imgItem.contentMode = .scaleToFill
    }
}
