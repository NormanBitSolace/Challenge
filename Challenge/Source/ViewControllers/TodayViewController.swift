import UIKit

class TodayViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var data: [Any]? {
        didSet { didSetData() }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func didSetData() {
        tableView.reloadData()
    }
}
