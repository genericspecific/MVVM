import UIKit

class RootViewModel {
    let id: Int
    let title: String
    let URL: NSURL
    var loading: Bool = true
    var image: UIImage?
    var update: (() -> Void)?
    
    init(model: RootModel) {
        id = model.id
        title = "\(id). \(model.title.uppercaseString)"
        URL = NSURL(string: model.URLString)!
        
        let conf = NSURLSessionConfiguration.defaultSessionConfiguration()
        conf.requestCachePolicy = .ReloadIgnoringLocalCacheData
        NSURLSession(configuration: conf).dataTaskWithURL(URL) { [weak self] (data, response, error) -> Void in
            guard let data = data where error == nil && self != nil else {
                print("error: \(error?.localizedDescription)")
                return
            }
            
            self?.loading = false
            self?.image = UIImage(data: data)
            self?.update?()
        }.resume()
        
        update?()
    }
    
    static func getAll(completion: [RootViewModel] -> Void) {
        return RootModel.getAll() { model in
            completion(model.map( RootViewModel.init ))
        }
    }
    
    static func getDetail(id: Int, completion: DetailViewModel? -> Void) {
        DetailViewModel.get(id) { viewModel in
            completion(viewModel)
        }
    }
    
    static var title: String {
        return "Overview"
    }
}