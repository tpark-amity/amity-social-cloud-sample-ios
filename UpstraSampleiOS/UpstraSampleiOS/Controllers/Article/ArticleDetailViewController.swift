
import UIKit
import UpstraUIKit
import EkoChat
class ArticleDetailViewController: BaseViewController,UITextFieldDelegate {
    @IBOutlet weak var tblComments: UITableView!
    @IBOutlet weak var txtComment: UITextField!
    @IBOutlet weak var lblMake: UILabel!
    @IBOutlet weak var lblBrand: UILabel!
    @IBOutlet weak var lblHeadline: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var btnBookMark: UIButton!
    @IBOutlet weak var heightScrollView: NSLayoutConstraint!

    var item:ArticleItemModel!
    var source = [CommentModel]() {
        didSet {
            self.updateCommentsData()
        }
    }
    var parentId:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        Global.shared.ekoManager.getAllComments(for: self.item.channelid) { (comments) in
            self.source = comments
        }
    }
   func configure()  {
        self.tblComments.register(UINib(nibName: TableViewCellNames.LiveCommentTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: TableViewCellNames.LiveCommentTableViewCell.rawValue)
        self.tblComments.rowHeight = UITableView.automaticDimension
        self.tblComments.transform = CGAffineTransform (scaleX: 1,y: -1);
        self.tblComments.estimatedRowHeight = 60
         self.lblBrand.text = item.brand
         self.lblMake.text = item.make
         self.lblHeadline.text = item.headline
         self.lblDescription.text = item.description
         self.btnBookMark.isSelected = item.isSaved
         self.imgItem.imageFromUrl(urlString: item.coverImage)
         self.imgItem.contentMode = .scaleToFill
         self.calculateScrollHeight()
     }
    func calculateScrollHeight()  {
        let labelHeight = self.lblDescription.text?.heightWithConstrainedWidth(width: ScreenSize.SCREEN_WIDTH - 32, font: UIFont(name: AppFonts.SFUITextRegular, size: 15.0)!)
        var tableHeight = 0
        for each in self.source{
            tableHeight += Int(each.getSizeForCommentBox().height) + 40
        }
        self.heightScrollView.constant = CGFloat(430 + Int(labelHeight!) + tableHeight)
    }
    func updateCommentsData()  {
        GCD.async(.Main) {
        self.tblComments.reloadData()
        self.calculateScrollHeight()
        }
    }
    @IBAction func actionClose(_ sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func actionAddToBookMark(_ sender:UIButton){
        self.createAlert(titletext: "", messagetext: AppMessages.noFunctionalityMessage)        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if !textField.text!.isEmpty{
            _=Global.shared.ekoManager.addComment(referenceId:self.item.channelid, parentId: self.parentId, commentText: textField.text!)
            Global.shared.ekoManager.getAllComments(for: self.item.channelid) { (comments) in
                self.source = comments
            }
            textField.text = ""
        }
        self.parentId = nil
        return true
    }
}
extension ArticleDetailViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.source.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellNames.LiveCommentTableViewCell.rawValue, for: indexPath) as! LiveCommentTableViewCell
        cell.configure(comment: self.source[indexPath.row],showOption:true)
        cell.selectionStyle = .none
        cell.transform = CGAffineTransform (scaleX: 1,y: -1);
        cell.index = indexPath.row
        cell.delegate = self
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.source[indexPath.row].getSizeForCommentBox().height + 40
    }
}
extension ArticleDetailViewController:LiveCommentTableViewCellDelegate{
    func actionReply(index: Int) {
        self.parentId = self.source[index].id
        self.txtComment.becomeFirstResponder()
    }
    func actionLike(index: Int) {
        if self.source[index].isLiked{
          _ = Global.shared.ekoManager.removeLike(to: self.source[index].id)
            self.source[index].totalLikes -= 1
        }else{
          _ = Global.shared.ekoManager.addLike(to: self.source[index].id)
            self.source[index].totalLikes += 1
        }
            self.source[index].isLiked = !self.source[index].isLiked
            GCD.async(.Main) {
                self.tblComments.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
            }
    }
}
