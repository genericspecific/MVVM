import UIKit

class RootViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var model: [RootViewModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = RootViewModel.getAll()
        tableView.dataSource = self
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
