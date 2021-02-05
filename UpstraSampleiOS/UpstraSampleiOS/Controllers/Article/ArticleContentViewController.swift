
import UIKit

class ArticleContentViewController: UIViewController {

    var pageIndex: Int = 0
    var source = ArticleModel()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var liveCollectionView: UICollectionView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var heightScroll: NSLayoutConstraint!
    @IBOutlet weak var heightLiveCollection: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblTitle.text = self.source.name
        self.heightLiveCollection.constant = self.source.liveItems.count > 0 ? 160 : 0
        self.heightScroll.constant = heightLiveCollection.constant + (ScreenSize.SCREEN_WIDTH) + CGFloat((95 * self.source.otherItems.count)) + 70
    }
    func moveToLiveDetail(_ item: LiveStreamModel) {
        GCD.async(.Main) {
            let vc = UIStoryboard.init(name: StoryBoardNames.Livestream.rawValue, bundle: nil).instantiateViewController(withIdentifier: ControllerNames.LiveStreamViewController.rawValue) as! LiveStreamViewController
                  vc.dataModel = item
                  self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension ArticleContentViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ArticleCollectionViewCellDelegate{
    func saveItem(index: Int) {
        self.source.topItems[index].isSaved = !self.source.topItems[index].isSaved
        GCD.async(.Main) {
            self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == self.collectionView ? self.source.topItems.count : self.source.liveItems.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellNames.ArticleCollectionViewCell.rawValue, for: indexPath) as! ArticleCollectionViewCell
        cell.index = indexPath.row
        cell.delegate = self
        cell.configure(item: self.source.topItems[indexPath.row])
        return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellNames.LiveItemCollectionViewCell.rawValue, for: indexPath) as! LiveItemCollectionViewCell
            cell.configure(item: self.source.liveItems[indexPath.row])
            return cell
        }
       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView{
        let width = (ScreenSize.SCREEN_WIDTH - 16)
        return CGSize(width: width, height: width)
        }else{
            return CGSize(width: ScreenSize.SCREEN_WIDTH - 80, height: 160)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if collectionView == self.collectionView{
        self.moveToDetail(with: self.source.topItems[indexPath.row])
        }else{
            self.moveToLiveDetail(self.source.liveItems[indexPath.row])
        }
    }
    func moveToDetail(with item:ArticleItemModel)  {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: ControllerNames.ArticleDetailViewController.rawValue) as! ArticleDetailViewController
        vc.item = item
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func moveToLiveDetail(with item: LiveStreamModel) {
           GCD.async(.Main) {
               let vc = UIStoryboard.init(name: StoryBoardNames.Livestream.rawValue, bundle: nil).instantiateViewController(withIdentifier: ControllerNames.LiveStreamViewController.rawValue) as! LiveStreamViewController
                     vc.dataModel = item
                     self.navigationController?.pushViewController(vc, animated: true)
           }
       }
}

extension ArticleContentViewController:UITableViewDelegate
,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.source.otherItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellNames.ArticleTableViewCell.rawValue, for: indexPath) as! ArticleTableViewCell
        cell.configure(item: self.source.otherItems[indexPath.row])
        return cell
       }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.moveToDetail(with: self.source.otherItems[indexPath.row])
    }
}
