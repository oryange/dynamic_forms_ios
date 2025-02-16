import Foundation

struct Section: Codable {
    let title: String
     let from: Int
     let to: Int
     let index: Int
     let uuid: String
     
     init(title: String, from: Int, to: Int, index: Int, uuid: String) {
         self.title = title
         self.from = from
         self.to = to
         self.index = index
         self.uuid = uuid
     }
}
