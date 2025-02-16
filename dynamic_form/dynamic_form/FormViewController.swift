import SwiftUI

struct FormViewController: View {
    var formType: String
    @StateObject private var viewModel = FormViewModel()
    
    var body: some View {
        VStack {
            if let form = viewModel.form {
                List(form.fields) { field in
                    FormFieldView(field: field)
                }
            } else {
                Text("Carregando...")
            }
        }
        .onAppear {
            viewModel.loadForm(formType: formType)
        }
    }
}
