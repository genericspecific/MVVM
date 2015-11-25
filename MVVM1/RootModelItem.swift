import Foundation

struct RootModelItem {
    let id: Int
    let title: String
    let URLString: String
}

extension RootModelItem {
    
    init?(dict: NSDictionary) {
        guard let
            id = dict["id"] as? Int,
            title = dict["title"] as? String,
            URLString = dict["thumbURL"] as? String
            else {
                print("incorrect JSON format")
                return nil
        }
        
        self.id = id
        self.title = title
        self.URLString = URLString
    }
}
