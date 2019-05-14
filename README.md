# Challenge
This app’s goal was to be a place where a user could choose a list of feeds (e.g. instagram activity famous quotes, today at NASA, famous quotes, historical events, RSS feeds, etc.) and view them daily, each as a section in a table view. Due to time constraints the app currently only shows NASA images. The imagined app would have a setup section to allow the user to choose from a list of feeds, each having a unique data source and cell types that illustrate key feed properties. If the data source contained additional meta-data the cell could be tapped to reveal that additional info.

This Frankenstein is a long way from that goal but it does have a number of architectural abstractions that would carry forward favorably.
* The navigation logic is contained by `AppController`, UIViewControllers are unaware of view controllers that come before or after. They are reusable.
* The view model layer builds model that can be consumed by UIView just assigning a property. All internationalization, currency conversion, etc. are handle here. This layer also knows if the data is to be accessed serially or in parallel. The models created from NASA’s API are grabbed serially and then that data is used to get the related images in parallel using `DispatchGroup`.
* The app calls for unique `UITableViewCell` types for each feed. The view model contains a cell identifier so that unique cell types could be dequeued generically by the table’s data source. If each of these cells also adopted a generic protocol for decoration, cells could be created very specific to their feed’s intention. Similarly, their tap delegates could each be unique so that `AppController` can push customized views to show each feed’s metadata.
* Since the model and view model layers are independent of other concerns, they are all easily testable. UIViewControllers are small/light-weight and typically should not require unit testing, and they can be easily re-created with test data for UI testing.
* Model are all `Codable` and leverage off of generic `Data` and `URL` extensions for creation. These implementations are easily updated to use Swift 5's new `Result` type.
* The app uses dependency injection with the data service so it can easily be swapped for testing. The protocol also hides implementation details of where the data resides e.g. REST API, iCloud, local storage, or project data.

### Game Plan
Start time: 9:58

1. Create a sample project with app coordinator, view model, and data source abstractions. 1/2 hour
1. Create data sources and reason about model. 1.5 hour Start time: 10:33
1. Create view model. 1 hour Start time: 11:30
1. Create UI to display. 1 hour Start time: 12:32

Finish time: 1:58

> Prioritize work with architectural concerns most  important and UI least. This will foster substantive discussions with the team.
