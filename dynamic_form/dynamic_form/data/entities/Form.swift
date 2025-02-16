import Foundation

struct Form: Codable {
    let title: String
    let fields: [Field]
    let sections: [Section]
}
