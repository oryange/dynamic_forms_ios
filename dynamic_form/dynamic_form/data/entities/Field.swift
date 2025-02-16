import Foundation

struct Field: Codable {
    let type: String
    let label: String
    let name: String
    let required: Bool
    let uuid: String
    let options: [Option]?
    
    init(type: String, label: String, name: String, required: Bool, uuid: String, options: [Option]? = nil) {
        self.type = type
        self.label = label
        self.name = name
        self.required = required
        self.uuid = uuid
        self.options = options
    }
}
