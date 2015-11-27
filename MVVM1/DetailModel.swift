import Foundation

struct DetailModel: Equatable {
    let id: Int
    let title: String
    let content: String
    let thumbURLString: String
    let mainURLString: String
    
    static func get(id: Int, completion: DetailModel? -> Void) {
        RootModel.get(id) { model in
            completion(model)
        }
    }
}

func ==(left: DetailModel, right: DetailModel) -> Bool {
    return left.id == right.id
}

extension DetailModel {
    
    init?(dict: NSDictionary) {
        guard let
            id = dict["id"] as? Int,
            title = dict["title"] as? String,
            content = dict["content"] as? String,
            thumbURLString = dict["thumbURL"] as? String,
            mainURLString = dict["mainURL"] as? String
        else {
            print("incorrect JSON format")
            return nil
        }
        
        self.id = id
        self.title = title
        self.content = content
        self.thumbURLString = thumbURLString
        self.mainURLString = mainURLString
    }
}