
import UIKit
class MoreViewController: BaseViewController {
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblTotalPosts: UILabel!
    var source = Global.shared.appData.moreItems
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblUserName.text = USER_NAME
        Global.shared.ekoManager.getUserFeedCount(for: USER_ID) { (count) in
            GCD.async(.Main) {
                self.lblTotalPosts.text = count + " Posts"
            }
        }
    }
  
   
    func moveToShopDetail(_ item:ItemModel)  {
        GCD.async(.Main) {
            let vc = UIStoryboard.init(name: StoryBoardNames.Shop.rawValue, bundle: nil).instantiateViewController(withIdentifier: ControllerNames.ShopDetailViewController.rawValue) as! ShopDetailViewController
            vc.item = item
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.present(vc, animated: true, completion: nil)
        }
    }
    
    func moveToArticleDetail(_ item:ArticleItemModel)  {
        GCD.async(.Main) {
            let vc = UIStoryboard.init(name: StoryBoardNames.Article.rawValue, bundle: nil).instantiateViewController(withIdentifier: ControllerNames.ArticleDetailViewController.rawValue) as! ArticleDetailViewController
            vc.item = item
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func actionProfile(_ sender:UIButton)
    {
        let vc = UIStoryboard.init(name: StoryBoardNames.Eko.rawValue, bundle: nil).instantiateViewController(withIdentifier: ControllerNames.ProfileViewController.rawValue) as! ProfileViewController
        vc.userId = Global.shared.ekoManager.client?.currentUserId ?? "VW_iOS_Test_User"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension MoreViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? self.source.purchases.count : self.source.bookMarks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellNames.MoreItemTableViewCell.rawValue, for: indexPath) as! MoreItemTableViewCell
        indexPath.section == 0 ? cell.configurePurchase(item: self.source.purchases[indexPath.row]) : cell.configureBookMark(item: self.source.bookMarks[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellNames.MoreHeaderTableViewCell.rawValue) as! MoreHeaderTableViewCell
        cell.lblTitle.text = MORE_SECTIONS[section]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: 16)
        view.backgroundColor = .white
        let sub = UIView()
        sub.frame = CGRect(x: 0, y: 0, width: ScreenSize.SCREEN_WIDTH, height: 1)
        sub.backgroundColor = .lightGray
        view.addSubview(sub)
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 16
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0{
            //  moveToShopDetail(self.source.purchases[indexPath.row])
        }else{
            let moreItem = self.source.bookMarks[indexPath.row]
            if moreItem.isArticle{
                //                self.moveToArticleDetail(Global.shared.appData.articleList.getItem(articleId: moreItem.mainId, itemId: moreItem.id)!)
            }else{
                //                self.moveToShopDetail(Global.shared.appData.shopList.getItem(shopId: moreItem.mainId, itemId: moreItem.id)!)
            }
        }
    }
}


