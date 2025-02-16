import Foundation

struct Field: Codable {
    let type: String
    let label: String
    let name: String
    let required: Bool
    let uuid: String
    let options: [Option]?
}
