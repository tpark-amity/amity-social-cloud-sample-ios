
import Foundation
import UIKit
import EkoChat
class CommentModel:Codable {
    var id: String = ""
    var name: String = ""
    var image: String = ""
    var time: String = ""
    var comment: String = ""
    var isLiked:Bool  = false
    var totalLikes:Int  = 0
    var parentId:String?
    var childs = [CommentModel]()
    init() {
        self.id = ""
        self.name = ""
        self.image = ""
        self.time = ""
        self.comment = ""
        self.isLiked = false
        self.totalLikes  = 0
        self.parentId = nil
        self.childs = [CommentModel]()
    }
    init(commentObject:EkoComment) {
        self.id = commentObject.commentId
        self.name = commentObject.user?.displayName ?? ""
        self.image = commentObject.user?.avatarCustomUrl ?? ""
     //   self.time = commentObject.createdAt
        self.comment = commentObject.data?.first?.value as! String
        self.isLiked = commentObject.myReactions.count > 0 ? true:false
        self.totalLikes = Int(commentObject.reactionsCount)
        self.parentId = commentObject.parentId
    }
    init(json: [String:Any]){
        self.id = json["id"] as? String ?? "0"
        self.name = json["name"] as? String ?? ""
        self.image = json["image"] as? String ?? ""
        self.time = json["time"] as? String ?? ""
        self.comment = json["comment"] as? String ?? ""
       }
    func addChild(commentObject:CommentModel) {
        self.childs.append(commentObject)
    }
    func getSizeForCommentBox() -> CGSize {
        let sizedWidth = self.parentId == nil ? GENERAL_COMMENT_WIDTH : GENERAL_COMMENT_WIDTH - 35
        let nameWidth = self.name.widthWithConstrainedHeight(height: 17, font:UIFont(name: AppFonts.SFUITextSemiBold, size: 13.0)!)
               let timeWidth = self.time.widthWithConstrainedHeight(height: 17, font:UIFont(name: AppFonts.SFUITextRegular, size: 13.0)!)
               let commentWidth = self.comment.widthWithConstrainedHeight(height: 17, font:UIFont(name: AppFonts.SFUITextRegular, size: 15.0)!) + 24
               let commentHeight = self.comment.heightWithConstrainedWidth(width: sizedWidth, font:UIFont(name: AppFonts.SFUITextRegular, size: 15.0)!) + 40
               let topWidth = nameWidth + timeWidth + 38
               var width = topWidth > commentWidth ? topWidth : commentWidth
               width = width > sizedWidth ? sizedWidth : width
               let height = commentHeight > 60 ? commentHeight : 60
        return CGSize(width: width, height: height)
    }
}

