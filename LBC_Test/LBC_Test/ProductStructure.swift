// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

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

struct ID: Codable {
    let id: Int
    let name: String
}

typealias Welcome = [ID]

