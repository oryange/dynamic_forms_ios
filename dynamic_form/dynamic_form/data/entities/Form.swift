import Foundation

struct Form: Codable {
    let title: String
    let fields: [Field]
    let sections: [Section]
    
    var elements: [FormElement] {
        var combinedElements: [FormElement] = []
        
        combinedElements.append(contentsOf: fields.map { FormElement.field($0) })
        
        combinedElements.append(contentsOf: sections.map { FormElement.section($0) })
        
        return combinedElements
    }
}
