import UIKit

class RootViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var model: [RootViewModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = RootViewModel.title
        RootViewModel.getAll() { [weak self] viewModels in
            self?.model = viewModels
        }
        tableView.dataSource = self
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetailIdentifier" {
            let index = tableView.indexPathForSelectedRow?.row ?? 0
            let viewController = segue.destinationViewController as! DetailViewController
            RootViewModel.getDetail(index) { detailViewModel in
                viewController.model = detailViewModel
            }
        }
    }
    
    func handleUpdate(indexPath: NSIndexPath) {
        tableView.beginUpdates()
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        tableView.endUpdates()
    }
}


extension RootViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let item = model[indexPath.row]
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
        return model.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}
