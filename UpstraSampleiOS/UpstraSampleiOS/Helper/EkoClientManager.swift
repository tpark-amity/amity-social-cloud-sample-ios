
import Foundation
import UpstraUIKit
import EkoChat

let EKO_API_KEY = "b3babb0b3a89f4341d31dc1a01091edcd70f8de7b23d697f"
let USER_NAME = "Alicia Mabborang"
let USER_ID = "alicia_mabborang"
let EKO_SDK_ENIVIRONEMENT = ["sdk_environment":"https://api.ekomedia.technology/"]
let DISPLAY_NAME_KEY = "displayName"
class EkoClientManager {
    var client:EkoClient? = EkoClient(apiKey: EKO_API_KEY)
    var commentRepo: EkoCommentRepository? = nil
    var reactionsRepo:EkoReactionRepository? = nil
    var postComments: EkoCollection<EkoComment>?
    var postCommentsNotification: EkoNotificationToken?
    var userFeedNotification: EkoNotificationToken?
    var feedRepo: EkoFeedRepository?
   
    init() {
        let theme = EkoTheme(primary: UIColor.black, secondary: nil, alert: nil, highlight: nil, base: nil, baseInverse: nil, messageBubble: nil, messageBubbleInverse: nil)
        EkoClient.setEkoConfig(EKO_SDK_ENIVIRONEMENT)
        UpstraUIKitManager.setup(EKO_API_KEY)
        UpstraUIKitManager.registerDevice(withUserId: USER_ID, displayName:USER_NAME)
        UpstraUIKitManager.set(theme: theme)
        UpstraUIKitManager.client.setUserMetadata([DISPLAY_NAME_KEY:USER_NAME], completion: { (success, erroe) in
            print(success)
            self.initilizeRepositories()
        })
    }
    func initilizeRepositories() {
        self.client = UpstraUIKitManager.client
        self.commentRepo = EkoCommentRepository(client: client!)
        self.reactionsRepo = EkoReactionRepository(client: client!)
        self.feedRepo = EkoFeedRepository(client: client!)
    }
    func getUserFeedCount(for userId:String, completion: @escaping (String) -> Void) {
        let feedCollection = feedRepo?.getUserFeed(userId, sortBy: .lastCreated, includeDeleted: false)
        userFeedNotification = feedCollection?.observe({ (collection, _, error) in
            completion("\(feedCollection?.count() ?? 0)")
        })
    }
    func getCommentsCount(for postId:String, completion: @escaping (String) -> Void) {
        postComments = commentRepo?.comments(withReferenceId: postId, referenceType: .post, filterByParentId: false, parentId: nil, orderBy: .descending, includeDeleted: false)
        postCommentsNotification = postComments?.observeOnce({ (collection, change, err) in
            completion("\(collection.count())")
        })
    }
    func getAllComments(for postId:String, completion: @escaping ([CommentModel]) -> Void) {
        postComments = commentRepo?.comments(withReferenceId: postId, referenceType: .post, filterByParentId: false, parentId: nil, orderBy: .descending, includeDeleted: false)
        postCommentsNotification = postComments?.observe({(collection, change, err) in
            completion(self.mapCommentData(commentsData: collection))
        })
    }
    func mapCommentData(commentsData: EkoCollection<EkoComment>) -> [CommentModel] {
        var parents = [CommentModel]()
        var childs = [CommentModel]()
        var result = [CommentModel]()
        for i in 0..<commentsData.count(){
            guard let commentObj = commentsData.object(at: i)  else {
                return [CommentModel]()
            }
            let vm = CommentModel(commentObject: commentObj)
            if let _ = vm.parentId{
                childs.append(vm)
            }else{
                parents.append(vm)
            }
        }
        for eachChild in childs{
            for eachParent in parents{
                if eachParent.id.elementsEqual(eachChild.parentId!){
                    eachParent.childs.append(eachChild)
                }
            }
        }
        for each in parents{
            result.append(contentsOf: each.childs)
            result.append(each)
            }
        return result
    }
    func addLike(to commentId:String) -> Bool {
        var result = false
        self.reactionsRepo?.addReaction(CommentReactions.like.rawValue, referenceId: commentId, referenceType: .comment, completion: { (res, err) in
            if let _ = err{
                result = false
            }else{
                result = true
            }
        })
        return result
    }
    func removeLike(to commentId:String) -> Bool {
        var result = false
        self.reactionsRepo?.removeReaction(CommentReactions.like.rawValue, referenceId: commentId, referenceType: .comment, completion: { (res, err) in
            if let _ = err{
                result = false
            }else{
                result = true
            }
        })
        return result
    }
    func addComment(referenceId:String,parentId:String?,commentText:String) -> Bool {
           var result = false
        let commentObject: EkoObject<EkoComment> = (self.commentRepo?.createComment(withReferenceId: referenceId, referenceType: .post, parentId: parentId, text: commentText))!
        _ = commentObject.observe { commentObject, error in
            if error != nil {
          result = false
        }
             result = true
       }
        return result
    }
}
