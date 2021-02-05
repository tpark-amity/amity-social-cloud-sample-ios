
import UIKit

class ShopContentViewController: UIViewController {
    var pageIndex: Int = 0
    var source = ShopModel()
    @IBOutlet weak var collectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        source = Global.shared.appData.shopList.shops[self.pageIndex]
        // Do any additional setup after loading the view.
    }
}
extension ShopContentViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ShopItemCollectionViewCellDelegate{
    func saveItem(index: Int) {
        self.source.items[index].isSaved = !self.source.items[index].isSaved
        GCD.async(.Main) {
            self.collectionview.reloadItems(at: [IndexPath(row: index, section: 0)])
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.source.items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellNames.ShopItemCollectionViewCell.rawValue, for: indexPath) as! ShopItemCollectionViewCell
        cell.index = indexPath.row
        cell.delegate = self
        cell.configure(item: self.source.items[indexPath.row])
        return cell
       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (ScreenSize.SCREEN_WIDTH - 48)/2
        return CGSize(width: width, height: 250)
       }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ControllerNames.ShopDetailViewController.rawValue) as! ShopDetailViewController
        vc.item = self.source.items[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
         self.navigationController?.present(vc, animated: true, completion: nil)
    }
}
