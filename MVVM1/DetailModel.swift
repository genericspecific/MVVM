import Foundation

enum DetailError: ErrorType {
    case BadJSON
}

struct DetailModel {
    let id: Int
    let title: String
    let content: String
    let imageURLString: String
    
    static func dictToDetailModel(dict: NSDictionary) throws -> DetailModel {
        guard let
            id = dict["id"] as? Int,
            title = dict["title"] as? String,
            content = dict["content"] as? String,
            imageURLString = dict["imageURL"] as? String
        else { throw DetailError.BadJSON }
        
        return DetailModel(id: id, title: title, content: content, imageURLString: imageURLString)
    }
    
    static func get(id: Int) throws -> DetailModel {
        return try dictToDetailModel(DetailModelService.get(id))
    }
}
