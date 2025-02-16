import SwiftUI

struct FormViewController: View {
    var formType: String
    @StateObject private var viewModel = FormViewModel()
    
    var body: some View {
        VStack {
            if let form = viewModel.form {
                List {
                    ForEach(form.elements) { element in
                        switch element {
                        case .field(let field):
                            FormFieldView(field: field)
                        case .section(let section):
                            FormSectionView(section: section)
                        }
                    }
                }
            } else {
                Text("loading...")
            }
        }
        .onAppear {
            viewModel.loadForm(formType: formType)
        }
    }
}
