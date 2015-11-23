import Foundation

struct RootViewModel {
    let id: Int
    let title: String
    let URL: NSURL
    var loading: Bool
    
    init(model: RootModel) {
        id = model.id
        title = "\(id). \(model.title.uppercaseString)"
        URL = NSURL(string: model.URLString)!
        loading = true
    }
    
    static func getAll() -> [RootViewModel] {
        return RootModel.getAll().map( RootViewModel.init )
    }
    
    static func getDetail(id: Int) throws -> DetailViewModel {
        return try DetailViewModel.get(id)
    }
}