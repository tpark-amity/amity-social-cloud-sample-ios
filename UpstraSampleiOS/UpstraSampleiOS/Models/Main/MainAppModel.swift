
import Foundation
class MainAppModel {
    var mainTitle: String = ""
    var shopList = ShopListModel()
    var articleList = ArticleListModel()
    var liveStream = LiveStreamModel()
    var moreItems = MoreModel()
    init() {
        mainTitle = ""
        shopList = ShopListModel()
        articleList = ArticleListModel()
        liveStream = LiveStreamModel()
        moreItems = MoreModel()
    }
    init(json: [String:Any]){
        self.mainTitle = json["mainTitle"] as? String ?? ""
        self.shopList = ShopListModel(json : (json["shops"] ?? []) as! [[String:Any]])
        self.articleList = ArticleListModel(json : (json["articles"] ?? []) as! [[String:Any]])
        //self.liveStream = LiveStreamModel(json : (json["livestream"] ?? {}) as! [String:Any])
        self.moreItems = MoreModel(json : json["moreItems"] as! [String : Any], shopList: self.shopList)

    }
}
