import Foundation

protocol DataService: class {
    func randomQuote(completion: (Quote) -> Void)
    func yesterdayNasa(completion: @escaping ([Nasa]?) -> Void)
}

class DataServiceImpl: DataService {

    func randomQuote(completion: (Quote) -> Void) {
        let quote = Quote(author: "Bob Barker", quote: "Happy Gilmore is my favorite movie.")
        completion(quote)
    }

    func yesterdayNasa(completion: @escaping ([Nasa]?) -> Void) {
        let dataParam = Date.yesterday.dateString("YYYY-M-d")
        let url = URL("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?earth_date=\(dataParam)&api_key=DEMO_KEY")
        url.getModel(type: NasaPhotos.self) { nasaPhotos in
            if let nasaPhotos = nasaPhotos {
                let photos = nasaPhotos.photos
                completion(Array(photos.prefix(min(2, photos.count))))
            }
        }
    }

}
