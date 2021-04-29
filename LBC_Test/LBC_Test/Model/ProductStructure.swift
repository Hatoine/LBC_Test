

import Foundation

// MARK: - WelcomeElement
struct Products:Decodable {
    let id: Int?
    let category_id: Int?
    let title: String?
    let description: String?
    let price: Int?
    let images_url: ImagesURL?
    let creation_date: String?
    let is_urgent: Bool?
    let siret: String?
}

// MARK: - ImagesURL
struct ImagesURL:Decodable {
    let small, thumb: String?
}

typealias Welcome = [Products]

