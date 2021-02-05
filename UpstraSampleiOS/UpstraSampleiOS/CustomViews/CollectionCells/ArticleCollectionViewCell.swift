
import UIKit
protocol ArticleCollectionViewCellDelegate {
    func saveItem(index:Int)
}
class ArticleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblMake: UILabel!
    @IBOutlet weak var lblBrand: UILabel!
    @IBOutlet weak var lblHeadLine: UILabel!
    @IBOutlet weak var lblDisscussion: UILabel!
    @IBOutlet weak var btnBookMakr: UIButton!
    @IBOutlet weak var viewDetailBox: UIView!
    @IBOutlet weak var widthImage: NSLayoutConstraint!
    @IBOutlet weak var heightImage: NSLayoutConstraint!
    var delegate:ArticleCollectionViewCellDelegate?
    var index = -1
    override func prepareForReuse() {
    }
    func configure(item:ArticleItemModel)  {
        self.widthImage.constant = ScreenSize.SCREEN_WIDTH - 32
        self.heightImage.constant = self.frame.size.height * 0.6
        self.lblBrand.text = item.brand
        self.lblMake.text = item.make
        self.lblHeadLine.text = item.headline
        self.btnBookMakr.isSelected = item.isSaved
        self.imgItem.imageFromUrl(urlString: item.coverImage)
        self.imgItem.contentMode = .scaleToFill
        self.viewDetailBox.backgroundColor = hexStringToUIColor(hex: item.detailBoxColor)
    }
    @IBAction func actionSaveitem(_ sender:UIButton){
        if let del = self.delegate{
            del.saveItem(index: self.index)
        }
    }
}
