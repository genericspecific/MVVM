import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    
    var modelId: Int?
    var model: DetailViewModel?
    
    override func viewWillAppear(animated: Bool) {
        guard let model = model else { return }
        
        title = model.title
        imageView.image = model.image
        contentLabel.text = model.content
    }
}
