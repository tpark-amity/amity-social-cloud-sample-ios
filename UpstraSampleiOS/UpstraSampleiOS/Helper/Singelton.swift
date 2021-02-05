
import Foundation
class Global {
    var appData: MainAppModel = MainAppModel()
    var ekoManager = EkoClientManager()
    lazy var cartCount = 0
    var isCorrectData = false
    class var shared : Global {
        struct Static {
            static let instance : Global = Global()
        }
        return Static.instance
    }
     func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        return nil
    }
    func parse(jsonData: Data) {
        do {
            let responseDict = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [String:Any]
            self.appData = MainAppModel(json : responseDict["data"] as! [String : Any])
          isCorrectData = true
        } catch {
            isCorrectData = false
            print("decode error")
        }
    }
    func saveDefaults(){
        let defaults = UserDefaults.standard
        defaults.synchronize()
    }
    func loadDefaults(){
        _ = UserDefaults.standard
    }
    struct defaultsKeys {
        static let userId = "userId"
    }
}


