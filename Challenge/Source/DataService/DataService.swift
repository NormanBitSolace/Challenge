import Foundation

protocol DataService: class {
    func randomQuote(completion: (Quote) -> Void)
}

class DataServiceImpl: DataService {
    func randomQuote(completion: (Quote) -> Void) {
        let quote = Quote(author: "Bob Barker", quote: "Happy Gilmore is my favorite movie.")
        completion(quote)
    }

}
