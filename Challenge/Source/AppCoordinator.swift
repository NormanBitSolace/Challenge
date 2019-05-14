import UIKit
import MapKit

final class AppCoordinator: NSObject {

    let navigator: Navigator
    let dataService: DataService

    init(appNavigator: Navigator, dataService: DataService) {
        self.navigator = appNavigator
        self.dataService = dataService
    }

    func start() {
        navigator.root(type: TodayViewController.self, storyboardName: "Today") { vc in
            vc.delegate = self
            vc.calendarData = TodayCalendarViewModel.build()
            TodayTableViewModel.build(dataService: self.dataService) { viewModels in
                vc.loadingView.stopAnimating()
                vc.data = viewModels
//                print(viewModels)
            }
        }
    }
}

extension AppCoordinator: TodayViewControllerDelegate {
    func handleTap(_ model: TodayTableCellViewModel) {
        navigator.push() { vc in
            let imageView = UIImageView(frame: vc.view.bounds)
            imageView.image = model.image
            vc.view.addSubview(imageView)
        }
    }
}
