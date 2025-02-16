import SwiftUI

class FormViewModel: ObservableObject {
    @Published var form: Form?
    
    private let repository = AssetFormRepository()
    
    func loadForm(formType: String) {
        let filename = formType == "FORM_ONE" ? "200-form" : "all-fields"
        form = repository.getForm(filename: filename)
    }
}
