
import UIKit
import EkoChat
import UpstraUIKit

class CustomChatTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: CollectionViewCellNames.ChatCustomCollectionViewCell.rawValue, bundle:nil)
        collectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCellNames.ChatCustomCollectionViewCell.rawValue)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return 6
       }
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellNames.ChatCustomCollectionViewCell.rawValue, for: indexPath) as! ChatCustomCollectionViewCell
        return cell
       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 215)
    }
}
