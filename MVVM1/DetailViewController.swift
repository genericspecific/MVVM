import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var viewModel: DetailViewModel! {
        didSet {
            guard let viewModel = viewModel where isViewLoaded() else { return }
            
            updateWithViewModel(viewModel)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        guard let viewModel = viewModel else { return }
        
        updateWithViewModel(viewModel)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        viewModel?.update = nil
        viewModel = nil
        imageView.image = nil
    }
    
    func updateWithViewModel(viewModel: DetailViewModel) {
        title = viewModel.title
        contentLabel.text = viewModel.content
        imageView.image = viewModel.image
        if viewModel.loading {
            viewModel.update = { [weak self] in
                NSOperationQueue.mainQueue().addOperationWithBlock{
                    self?.updateWithViewModel(viewModel)
                }
            }
            spinner.hidden = false
            spinner.startAnimating()
        } else {
            viewModel.update = nil
            spinner.hidden = true
            spinner.stopAnimating()
        }
    }
}
