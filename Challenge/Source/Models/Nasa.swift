import Foundation

struct NasaPhotos: Codable {
    let photos: [Nasa]
}

struct Rover: Codable {
    let name: String
}

struct Nasa: Codable {
    let img_src: String
    let rover: Rover
}
