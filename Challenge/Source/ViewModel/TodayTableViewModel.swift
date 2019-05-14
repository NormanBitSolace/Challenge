import UIKit

struct TodayTableViewModel {
    let sections: [TodayTableSectionViewModel]
}

struct TodayTableCellViewModel {
    let identifier: String
    let name: String
    let image: UIImage
}

extension TodayTableCellViewModel {
    init?(identifier: String, image: UIImage, model: NasaModel) {
        guard let name = model.rover?.name else { return nil }
        self.identifier = identifier
        self.image = image
        self.name = name
    }
}

struct TodayTableSectionViewModel {
    let title: String
    let cellData: [TodayTableCellViewModel]
}

extension TodayTableViewModel {

    static func build(dataService: DataService, completion: @escaping (TodayTableViewModel?) -> Void) {
        var sections = [TodayTableSectionViewModel]()
        nasaCells(dataService) { section in
            if let section = section {
                sections.append(section)
            }
            completion(TodayTableViewModel(sections: sections))

        }

    }

    fileprivate static func nasaCells(_ dataService: DataService, completion: @escaping (TodayTableSectionViewModel?) -> Void) {
        dataService.yesterdayNasa { models in
            guard let nasaModels = models else { return completion(nil) }
            var vmData = [(UIImage, NasaModel)]()
            let group = DispatchGroup()
            for model in nasaModels {
                group.enter()
                if let urlStr = model.img_src?.replacingOccurrences(of: "http", with: "https"),
                    let url = URL(string: urlStr) {
                    url.getImage { image in
                        if let image = image {
                            vmData.append((image, model))
                        }
                        group.leave()
                    }
                }
            }
            group.notify(queue: .main) { [] in
                let cells = vmData.compactMap { TodayTableCellViewModel(identifier: "NasaCell", image: $0.0, model: $0.1)}
                let section = TodayTableSectionViewModel(title: "NASA", cellData: cells)
                completion(section)
            }
        }
    }

}
