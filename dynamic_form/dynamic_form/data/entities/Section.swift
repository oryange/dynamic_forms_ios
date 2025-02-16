import Foundation

struct Section: Codable, Identifiable {
    var id: String { uuid }
    let title: String
    let from: Int
    let to: Int
    let index: Int
    let uuid: String
}
