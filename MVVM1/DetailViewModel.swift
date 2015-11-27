import UIKit

class DetailViewModel {
    
    static let loadingLabel = "Loading..."
    
    var title: String = DetailViewModel.loadingLabel
    var content: String
    var imageURL: NSURL? {
        didSet {
            guard let url = imageURL else {
                self.image = nil
                self.update?()
                return
            }
            
            NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration()).dataTaskWithURL(url) { [weak self] (data, response, error) -> Void in
                self?.loading = false
                
                guard let data = data where error == nil && self != nil else {
                    print("error: \(error?.localizedDescription)")
                    return
                }
                
                self?.image = UIImage(data: data)
                self?.update?()
            }.resume()
        }
    }
    var image: UIImage? = nil
    var loading: Bool = true
    var update: (() -> Void)?
    var model: DetailModel? {
        didSet {
            guard model != oldValue else { return }
            
            self.title = model?.title ?? ""
            self.content = model?.content ?? ""
            self.imageURL = NSURL(string: model?.mainURLString ?? "")
            self.update?()
        }
    }
    
    init(title: String, content: String, imageURLString: String) {
        self.title = title
        self.content = content
        imageURL = NSURL(string: imageURLString)
    }
    
    deinit {
        
    }
    
    static func get(id: Int) -> DetailViewModel {
        let viewModel = DetailViewModel(title: "", content: "", imageURLString: "")
        
        DetailModel.get(id) { model in
            viewModel.model = model
        }
            
        return viewModel
    }
}