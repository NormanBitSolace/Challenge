import UIKit

protocol TodayViewControllerDelegate {
    func handleTap(_ model :TodayTableCellViewModel)
}

class TodayViewController: UIViewController {

    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dayOfMonthLabelView: UILabel!
    @IBOutlet weak var dayLabelView: UILabel!
    @IBOutlet weak var monthYearLabelView: UILabel!

    var delegate: TodayViewControllerDelegate?

    var data: TodayTableViewModel? {
        didSet { tableView.reloadData() }
    }

    var calendarData: TodayCalendarViewModel? {
        didSet {
            dayOfMonthLabelView?.text = calendarData?.dayOfMonth
            dayLabelView?.text = calendarData?.day
            monthYearLabelView?.text = calendarData?.monthYear
        }
    }
}


extension TodayViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data?.sections.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.sections[section].cellData.count ?? 0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = data?.sections[section] else { fatalError("Data corrupted.") }
        return section.title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = data?.sections[indexPath.section].cellData[indexPath.row] else { fatalError("Data corrupted.") }
        if let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier) as? NasaCell {
            cell.nameLabel?.text = item.name
            cell.nasaImageView.image = item.image
            return cell
        }
        fatalError("Cell not assocated for identifier: '\(item.identifier)'.")
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = data?.sections[indexPath.section].cellData[indexPath.row] else { fatalError("Data corrupted.") }
        delegate?.handleTap(item)
    }
}
