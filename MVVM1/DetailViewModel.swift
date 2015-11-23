import Foundation

struct DetailViewModel {
    let title: String
    let content: String
    let imageURL: NSURL
    var loading: Bool = true
    
    init(model: DetailModel) {
        title = model.title
        content = model.content
        imageURL = NSURL(string: model.imageURLString)!
    }
    
    static func get(id: Int) throws -> DetailViewModel {
        return try DetailViewModel(model: DetailModel.get(id))
    }
}