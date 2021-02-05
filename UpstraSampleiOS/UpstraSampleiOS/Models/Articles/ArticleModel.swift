
import Foundation
import Foundation
class ArticleModel {
    var id: String = ""
    var name: String = ""
    var topItems: [ArticleItemModel] = []
    var otherItems: [ArticleItemModel] = []
    var liveItems: [LiveStreamModel] = []
    init() {
        self.id = ""
        self.name = ""
        self.topItems = []
        self.otherItems = []
        self.liveItems = []
    }
    init(json: [String:Any]){
        self.id = json["id"] as? String ?? "0"
        self.name = json["name"] as? String ?? "0"
        for each in json["topItems"] as? [[String:Any]] ?? [] {
            self.topItems.append(ArticleItemModel(json: each))
        }
        for each in json["otherItems"] as? [[String:Any]] ?? [] {
            self.otherItems.append(ArticleItemModel(json: each))
        }
        for each in json["liveItems"] as? [[String:Any]] ?? [] {
            self.liveItems.append(LiveStreamModel(json: each))
        }
    }
}
class ArticleListModel {
    var articles: [ArticleModel] = []
    init() {
        articles = []
    }
    init (json: [[String:Any]]){
        for each in json {
            let article = ArticleModel(json: each)
            self.articles.append(article)
        }
    }
    func getItem(articleId:String, itemId:String) -> ArticleItemModel? {
           for each in self.articles{
               if each.id.elementsEqual(articleId){
                let allItems = each.otherItems + each.topItems
                for eachItem in allItems{
                       if eachItem.id.elementsEqual(itemId){
                           return eachItem
                       }
                   }
               }
           }
           return nil
       }    
}
