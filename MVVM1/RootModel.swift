import Foundation

struct RootModel {
    
    enum RootError: ErrorType {
        case BadJSON
    }
    
    let id: Int
    let title: String
    let URLString: String
    
    static func getAll() -> [RootModel] {
        let raw: [NSDictionary]
        do {
            raw = try RootModelService.getAll()
        } catch {
            print("Couldnt load JSON")
            raw = []
        }
        
        let model: [RootModel]
        do {
            try model = raw.map( RootModel.dictToRootModel )
        } catch {
            print("Model creation Failed")
            model = []
        }
        return model
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
