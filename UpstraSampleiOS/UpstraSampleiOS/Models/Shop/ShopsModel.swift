
import Foundation
class ShopModel {
    var id: String = ""
    var name: String = ""
    var items: [ItemModel] = []
    init() {
        self.id = ""
        self.name = ""
        self.items = []
    }
    init(json: [String:Any]){
        self.id = json["id"] as? String ?? "0"
        self.name = json["name"] as? String ?? "0"
        for each in json["items"] as? [[String:Any]] ?? [] {
            self.items.append(ItemModel(json: each))
        }
    }
}
class ShopListModel {
    var shops: [ShopModel] = []
    init() {
        shops = []
    }
    init (json: [[String:Any]]){
        for each in json {
            let shop = ShopModel(json: each)
            self.shops.append(shop)
        }
    }
    func getItem(shopId:String, itemId:String) -> ItemModel? {
        for each in self.shops{
            if each.id.elementsEqual(shopId){
                for eachItem in each.items{
                    if eachItem.id.elementsEqual(itemId){
                        return eachItem
                    }
                }
            }
        }
        return nil
    } 
}
