import UIKit

class RootViewModelItem {
    let id: Int
    let title: String
    let thumbURL: NSURL
    var loading: Bool = true
    var image: UIImage? = nil
    var update: (() -> Void)? = nil
    
    init(id: Int, title: String, thumbURL: NSURL) {
        self.id = id
        self.title = title
        self.thumbURL = thumbURL
        
        NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration()).dataTaskWithURL(thumbURL) { [weak self] (data, response, error) -> Void in
            self?.loading = false
            
            guard let data = data where error == nil else {
                print("error: \(error?.localizedDescription)")
                return
            }
            
            self?.image = UIImage(data: data)
            self?.update?()
        }.resume()
    }
}


extension RootViewModelItem {
    convenience init?(model: DetailModel) {
        guard let URL = NSURL(string: model.thumbURLString) else { return nil }
        
        self.init(id: model.id, title: model.title.uppercaseString, thumbURL: URL)
    }
}