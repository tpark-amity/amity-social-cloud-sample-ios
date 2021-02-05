
import UIKit
import Alamofire
protocol ShopItemCollectionViewCellDelegate {
    func saveItem(index:Int)
}
class ShopItemCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSub: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblViews: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    var delegate:ShopItemCollectionViewCellDelegate?
    var index = -1
    override func prepareForReuse() {
        self.imgItem.image = UIImage(named: "tropicalstorm")
        super.prepareForReuse()
    }
    func configure(item:ItemModel)  {
        self.lblTitle.text = item.category
        self.lblSub.text = item.name
        self.lblPrice.text = "$"+item.price
        self.lblViews.text = item.discussions
        self.btnSave.isSelected = item.isSaved
        self.imgItem.imageFromUrl(urlString: item.coverImage)
        self.imgItem.contentMode = .scaleAspectFit
    }
    @IBAction func actionSaveitem(_ sender:UIButton){
        if let del = self.delegate{
            del.saveItem(index: self.index)
        }
    }
}
