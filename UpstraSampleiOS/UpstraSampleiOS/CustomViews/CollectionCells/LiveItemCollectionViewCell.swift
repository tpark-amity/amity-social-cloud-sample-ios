
import UIKit
class LiveItemCollectionViewCell: UICollectionViewCell {
   @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblUserNWatching: UILabel!
    @IBOutlet weak var widthImageItem: NSLayoutConstraint!
    func configure(item:LiveStreamModel) {
        self.lblTitle.text = item.headline
        self.lblUserNWatching.text = item.name + " . \(item.viewers) Viewers"
        self.imgItem.imageFromUrl(urlString: item.coverImage)
        self.imgItem.contentMode = .scaleAspectFill
        self.widthImageItem.constant = ScreenSize.SCREEN_WIDTH - 80
    }
}
