import UIKit

extension URL {

    init(_ string: String) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("App assumes '\(string)' is a valid URL.")
        }
        self = url
    }

    func getModel<T: Codable>(type: T.Type, completion: @escaping (T?) -> Void) {
        var req = URLRequest(url: self)
        req.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let dataTask = URLSession.shared.dataTask(with: req) { data, _, _ in
            guard let data = data else { completion(nil); return }
            let model: T? = data.decode()
            completion(model)
        }
        dataTask.resume()
    }

}
