import UIKit

class DetailViewModel {
    let title: String
    let content: String
    let imageURL: NSURL
    var image: UIImage? = nil
    var loading: Bool = true
    var update: (() -> Void)?
    
    init(model: DetailModel) {
        title = model.title
        content = model.content
        imageURL = NSURL(string: model.imageURLString)!
        
        if let data = NSData(contentsOfURL: imageURL) {
            image = UIImage(data: data)
        }
        
        let conf = NSURLSessionConfiguration.defaultSessionConfiguration()
        conf.requestCachePolicy = .ReloadIgnoringLocalCacheData
        NSURLSession(configuration: conf).dataTaskWithURL(imageURL) { [weak self] (data, response, error) -> Void in
            guard let data = data where error == nil && self != nil else {
                print("error: \(error?.localizedDescription)")
                return
            }
            
            self?.loading = false
            self?.image = UIImage(data: data)
            self?.update?()
        }.resume()
    }
    
    static func get(id: Int, completion: DetailViewModel? -> Void) {
        DetailModel.get(id) { model in
            guard let model = model else {
                completion(nil)
                return
            }
            
            completion(DetailViewModel(model: model))
        }
    }
}