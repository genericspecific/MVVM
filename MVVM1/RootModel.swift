import Foundation

struct RootModel {
    
    enum RootError: ErrorType {
        case BadJSON
    }
    
    let id: Int
    let title: String
    let URLString: String
    
    static func getAll(completion: [RootModel] -> Void) {
        RootModelService.getAll() { raw in
            let model: [RootModel]
            do {
                model = try raw.map( RootModel.dictToRootModel )
            } catch {
                model = []
            }
            completion(model)
        }
    }
    
    static func dictToRootModel(dict: NSDictionary) throws -> RootModel {
        guard let
            id = dict["id"] as? Int,
            title = dict["title"] as? String,
            URLString = dict["thumbURL"] as? String
        else { throw RootError.BadJSON }
        
        return RootModel(id: id, title: title, URLString: URLString)
    }
}
