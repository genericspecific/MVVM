import UIKit

class RootViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var viewModel: RootViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = RootViewModel.get()
        updateWithViewMode(viewModel)
        tableView.dataSource = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetailIdentifier" {
            let index = tableView.indexPathForSelectedRow?.row ?? 0
            let id = viewModel.items[index].id
            let viewController = segue.destinationViewController as! DetailViewController
            viewController.viewModel = viewModel.getDetail(id)
        }
    }
    
    func handleUpdate(indexPath: NSIndexPath) {
        tableView.beginUpdates()
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        tableView.endUpdates()
    }
    
    func updateWithViewMode(viewModel: RootViewModel) {
        if viewModel.loading {
            viewModel.update = { [weak self] in
                NSOperationQueue.mainQueue().addOperationWithBlock { [weak self] in
                    self?.updateWithViewMode(viewModel)
                }
            }
            spinner.hidden = false
            spinner.startAnimating()
        } else {
            spinner.hidden = true
            spinner.stopAnimating()
            tableView.reloadData()
        }
        title = viewModel.title
    }
}


extension RootViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let item = viewModel.items[indexPath.row]
        if item.loading {
            item.update = { [weak self] in
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    self?.handleUpdate(indexPath)
                }
            }
        } else {
            item.update = nil
        }
        
        cell.textLabel?.text = item.title
        cell.imageView?.image = item.image
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}
