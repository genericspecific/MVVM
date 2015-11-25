import Foundation

struct RootModel {
    
    let items: [RootModelItem]
    
    static func get(completion: RootModel? -> Void) {
        RootModelService.getAll() { dict in
            let model = RootModel(dict: dict)
            completion(model)
        }
    }
}

extension RootModel {
    
    init?(dict: NSDictionary) {
        guard let itemsArray = dict["items"] as? [NSDictionary] else {
            return nil
        }
        
        self.items = itemsArray.flatMap{ RootModelItem.init(dict: $0) }
    }
}
