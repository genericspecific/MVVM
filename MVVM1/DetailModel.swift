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
    
    static func get(id: Int, completion: DetailModel? -> Void) {
        DetailModelService.get(id) { dict in
            guard let dict = dict else {
                completion(nil)
                return
            }
            
            let model:DetailModel?
            do {
                try model = DetailModel.dictToDetailModel(dict)
            } catch {
                model = nil
            }
            
            completion(model)
        }
    }
}
