import UIKit

class RootViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var model: [RootViewModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = RootViewModel.getAll()
        tableView.dataSource = self
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetailIdentifier" {
            let index = tableView.indexPathForSelectedRow?.row ?? 0
            let viewController = segue.destinationViewController as! DetailViewController
            do {
                viewController.model = try RootViewModel.getDetail(index)
            } catch {
                print("no model available for index \(index)")
            }
        }
    }
}


extension RootViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        let item = model[indexPath.row]
        cell.textLabel?.text = item.title
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}
//
//
//extension RootViewController: UITableViewDelegate {
//    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let vc = 
//    }
//}
