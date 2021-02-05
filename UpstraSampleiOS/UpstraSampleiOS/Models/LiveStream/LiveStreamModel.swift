
import Foundation

class LiveStreamModel {
    var id: String = ""
    var channelid: String = ""
    var headline: String = ""
    var name: String = ""
    var coverImage: String = ""
    var videourl: String = ""
    var videourlDetail: String = ""
    var viewers: String = ""
    init() {
        self.id = ""
        self.channelid = ""
        self.headline = ""
        self.name = ""
        self.coverImage = ""
        self.videourl = ""
        self.videourlDetail = ""
        self.viewers = ""
    }
    init(json: [String:Any]){
        self.id = json["id"] as? String ?? "0"
        self.channelid = json["channelid"] as? String ?? ""
        self.headline = json["headline"] as? String ?? ""
        self.name = json["name"] as? String ?? ""
        self.coverImage = json["coverImage"] as? String ?? ""
        self.videourl = json["videourl"] as? String ?? ""
        self.videourlDetail = json["videourlDetail"] as? String ?? ""
        self.viewers = json["viewers"] as? String ?? ""

    }
}

