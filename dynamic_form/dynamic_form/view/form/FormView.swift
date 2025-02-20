import SwiftUI

struct FormView: View {
    var filename: String
    @StateObject private var viewModel: FormViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(filename: String) {
        self.filename = filename
        _viewModel = StateObject(wrappedValue: FormViewModel())
    }
    
    var body: some View {
        ZStack {
            VStack {
                if let form = viewModel.formLiveData {
                    List {
                        ForEach(form.elements) { element in
                            switch element {
                            case .field(let field):
                                FormFieldView(field: field, filename: filename, removeField: { fieldToRemove in
                                    viewModel.removeFieldToFormInCache(filename: filename, removeField: fieldToRemove)
                                })
                                
                            case .section(let section):
                                FormSectionView(section: section, filename: filename, removeSection: { sectionToRemove in
                                    viewModel.removeFieldToFormInCache(filename: filename, removeSection: sectionToRemove)
                                })
                            }
                        }
                    }
                } else {
                    Text("Loading...")
                }
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    VStack(spacing: 16) {
                        Button(action: {
                            clearFormInputs()
                        }) {
                            Image(systemName: "trash")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        
                        NavigationLink(destination: FormEntriesView(filename: filename)) {
                            Image(systemName: "arrow.right.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28, height: 28)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            viewModel.getFormSelected(filename: filename)
        }
    }
    
    private func clearFormInputs() {
        viewModel.clearForm(filename: filename)
        
        DispatchQueue.main.async {
            self.viewModel.getFormSelected(filename: self.filename)
        }
    }
}
