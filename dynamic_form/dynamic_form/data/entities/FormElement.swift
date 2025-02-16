import SwiftUI

enum FormElement: Identifiable {
    case field(Field)
    case section(Section)
    
    var id: String {
        switch self {
        case .field(let field):
            return field.id
        case .section(let section):
            return section.id
        }
    }
}
