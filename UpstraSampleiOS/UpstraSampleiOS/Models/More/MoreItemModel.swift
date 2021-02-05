
import Foundation
class MoreItemModel {
    var id: String = ""
    var mainId: String = ""
    var title: String = ""
    var sub: String = ""
    var price: String = ""
    var coverImage: String = ""
    var isArticle: Bool = false
    init() {
        self.id = ""
        self.mainId = ""
        self.title = ""
        self.sub = ""
        self.price = ""
        self.coverImage = ""
        self.isArticle = false
    }
    init(json: [String:Any]){
        self.id = json["id"] as? String ?? "0"
        self.mainId = json["mainId"] as? String ?? "0"
        self.title = json["title"] as? String ?? ""
        self.sub = json["sub"] as? String ?? ""
        self.price = json["price"] as? String ?? ""
        self.coverImage = json["coverImage"] as? String ?? ""
        self.isArticle = json["isArticle"] as? Bool ?? false
       }
}
