import SwiftUI

struct FormEntriesView: View {
    @Environment(\.presentationMode) var presentationMode // Para a função de voltar
    let filename: String
    
    @StateObject private var viewModel = FormEntriesViewModel()
    @State private var selectedType: String = "text"
    @State private var label: String = ""
    @State private var isRequired: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    let fieldTypes = ["text", "textarea", "description", "number", "email", "file", "section"]
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Spacer()
                Text("Dynamic Form")
                    .font(.title)
                    .bold()
                Spacer()
            }
            
            Text("Select one type")
                .font(.headline)
            
            Picker("Field Type", selection: $selectedType) {
                ForEach(fieldTypes, id: \.self) { type in
                    Text(type).tag(type)
                }
            }
            .pickerStyle(MenuPickerStyle())
            
            TextField("Enter label", text: $label)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
            
            Toggle("Is this field required?", isOn: $isRequired)
                .padding(.horizontal)
            
            Button(action: addFieldToForm) {
                Text("Add Selected Type")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertMessage))
        }
    }
    
    private func addFieldToForm() {
        let trimmedLabel = label.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedLabel.isEmpty else {
            showAlert(message: "Label cannot be empty!")
            return
        }
        
        let wasAdded = selectedType == "section" ?
            viewModel.addSection(formSelected: filename, name: trimmedLabel) :
            viewModel.addField(formSelected: filename, type: selectedType, label: trimmedLabel, name: trimmedLabel, required: isRequired)
        
        showAlert(message: wasAdded ? "Entry added successfully!" : "Error adding entry!")
    }
    
    private func showAlert(message: String) {
        alertMessage = message
        showAlert = true
    }
}
