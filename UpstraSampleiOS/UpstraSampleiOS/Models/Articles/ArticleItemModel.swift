
import Foundation
class ArticleItemModel: Codable {
    var id: String = ""
    var channelid: String = ""
    var make: String = ""
    var brand: String = ""
    var headline: String = ""
    var isSaved: Bool = false
    var discussions: String = ""
    var description: String = ""
    var detailBoxColor: String = ""
    var coverImage: String = ""
    var comments: [CommentModel] = []
    init(json: [String:Any]){
        self.id = json["id"] as? String ?? "0"
        self.channelid = json["channelid"] as? String ?? ""
        self.make = json["make"] as? String ?? ""
        self.brand = json["brand"] as? String ?? ""
        self.isSaved = json["isSaved"] as? Bool ?? false
        self.headline = json["headline"] as? String ?? ""
        self.detailBoxColor = json["detailBoxColor"] as? String ?? ""
        self.coverImage = json["coverImage"] as? String ?? ""
         for each in json["comments"] as? [[String:Any]] ?? [] {
            self.comments.append(CommentModel(json: each))
        }
    }
}
