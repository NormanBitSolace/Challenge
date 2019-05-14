import Foundation

struct NasaPhotosModel: Codable {
    let photos: [NasaModel]
}

struct RoverModel: Codable {
    let name: String?
}

struct NasaModel: Codable {
    let img_src: String?
    let rover: RoverModel?
}
