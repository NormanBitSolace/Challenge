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
//            vc.delegate = self
//            vc.title = "Styles"
//            self.dataService.viewControllerStyleList { models in
//                vc.data = models
//            }
        }
//        navigator.rootNavigationController.setLargeNavigation()
    }
}
