
import UIKit
protocol LiveCommentTableViewCellDelegate:NSObjectProtocol {
    func actionLike(index:Int)
    func actionReply(index:Int)
}
class LiveCommentTableViewCell: UITableViewCell {
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblComment: UILabel!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnReply: UIButton!
    @IBOutlet weak var widthCommentBox: NSLayoutConstraint!
    @IBOutlet weak var heightComentBox: NSLayoutConstraint!
    @IBOutlet weak var heightOptionsBox: NSLayoutConstraint!
    @IBOutlet weak var widthLeftPusher: NSLayoutConstraint!

    var delegate:LiveCommentTableViewCellDelegate?
    var index:Int = -1
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configure(comment:CommentModel,showOption:Bool = false)  {
        self.heightOptionsBox.constant = 0
        self.widthCommentBox.constant = comment.getSizeForCommentBox().width
        self.heightComentBox.constant = comment.getSizeForCommentBox().height
        self.lblName.text = comment.name
        self.lblTime.text = comment.time
        self.lblComment.text = comment.comment
        if !comment.image.isEmpty{
        self.imgUser.imageFromUrl(urlString: comment.image)
            self.imgUser.contentMode = .scaleAspectFill
        }else{
            self.imgUser.image = UIImage(named: "user")
        }
        if showOption{
            self.viewBg.backgroundColor = .white
            self.lblName.textColor = .black
            self.lblTime.textColor = .black
            self.lblComment.textColor = .black
            self.heightOptionsBox.constant = 40
            self.btnLike.isSelected = comment.isLiked
            self.btnLike.setTitle(comment.totalLikes > 0 ? " \(comment.totalLikes)" : " Like" , for: .normal)
            self.btnLike.setTitleColor(comment.isLiked ? .black:.lightGray, for: .normal)
        }
        self.widthLeftPusher.constant = comment.parentId == nil ? 0 : 35
        self.btnReply.isHidden = comment.parentId != nil
    }
    @IBAction func actionLike(_ sender:UIButton){
        guard let del = self.delegate else {
            return
        }
        del.actionLike(index: self.index)
    }
    @IBAction func actionReply(_ sender:UIButton){
        guard let del = self.delegate else {
            return
        }
        del.actionReply(index: self.index)
    }
}
