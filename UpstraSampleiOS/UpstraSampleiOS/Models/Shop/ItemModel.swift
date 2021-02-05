
import Foundation
class ItemModel: Codable {
    var id: String = ""
    var category: String = ""
    var name: String = ""
    var price: String = ""
    var isSaved: Bool = false
    var isAddedToCard: Bool = false
    var discussions: String = ""
    var description: String = ""
    var coverImage: String = ""
    var detailImages: [String] = []
    var availableColors: [String] = []
    init(json: [String:Any]){
        self.id = json["id"] as? String ?? "0"
        self.category = json["category"] as? String ?? ""
        self.name = json["name"] as? String ?? ""
        self.price = json["price"] as? String ?? ""
        self.isSaved = json["isSaved"] as? Bool ?? false
        self.isAddedToCard = json["isAddedToCard"] as? Bool ?? false
        self.discussions = json["discussions"] as? String ?? "0"
        self.description = json["description"] as? String ?? ""
        self.coverImage = json["coverImage"] as? String ?? ""
        for each in json["detailImages"] as? [String] ?? [] {
            self.detailImages.append(each)
        }
        for each in json["availableColors"] as? [String] ?? [] {
            self.availableColors.append(each)
        }
    }
}

