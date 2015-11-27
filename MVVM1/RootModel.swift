import Foundation

struct RootModel: Equatable {
    
    let title: String
    let items: [DetailModel]
    
    static func get(completion: RootModel? -> Void) {
        RootModelService.getAll() { dict in
            let model = RootModel(dict: dict)
            completion(model)
        }
    }
    
    static func get(id: Int, completion: DetailModel? -> Void) {
        RootModelService.getAll() { dict in
            guard let rootModel = RootModel(dict: dict) else {
                completion(nil)
                return
            }
            
            completion(rootModel.items.filter{ $0.id == id }.first)
        }
    }
}

func ==(left: RootModel, right: RootModel) -> Bool {
    return left.items == right.items
}

extension RootModel {
    
    init?(dict: NSDictionary) {
        guard let
            title = dict["title"] as? String,
            itemsArray = dict["items"] as? [NSDictionary]
        else {
            return nil
        }
        
        self.title = title
        self.items = itemsArray.flatMap{ DetailModel.init(dict: $0) }
    }
}
