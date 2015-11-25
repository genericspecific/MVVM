import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    var modelId: Int?
    var model: DetailViewModel? {
        didSet {
            guard let model = model else { return }
            
            if model.loading {
                model.update = { [weak self] in
                    self?.imageView.image = model.image
                    self?.model?.update = nil
                }
            } else {
                model.update = nil
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        guard let model = model else { return }
        
        title = model.title
        contentLabel.text = model.content
        imageView.image = model.image
    }
}
