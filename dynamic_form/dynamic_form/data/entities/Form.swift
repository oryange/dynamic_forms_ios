import Foundation
struct Form: Decodable {
    let title: String
    let fields: [Field]
    let sections: [Section]
}
