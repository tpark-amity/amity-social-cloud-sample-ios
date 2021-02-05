import Foundation
class MoreModel {
    var bookMarks: [MoreItemModel] = []
    var purchases: [ItemModel] = []
    init() {
        self.bookMarks = []
        self.purchases = []
    }
    init(json: [String:Any],shopList:ShopListModel){
        for each in json["bookmarks"] as? [[String:Any]] ?? []{
            self.bookMarks.append(MoreItemModel(json: each))
        }
        for each in json["purchaseItemIds"] as? [[String:Any]] ?? []{
            let model = shopList.getItem(shopId: each["mainId"] as! String, itemId: each["id"] as! String )
            if let _ = model{
                self.purchases.append(model!)
            }
        }
    }
}
