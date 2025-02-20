import SwiftUI

struct FormFieldView: View {
    let field: Field
    let filename: String
    let preferences = FormLocalPreferences()
    var removeField: (Field) -> Void // Função para remover o campo
    
    @State private var textValue: String = ""
    @State private var numberValue: Double = 0
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(field.label)
                    .font(.headline)
                    .padding(.bottom, 5)
                
                switch field.type {
                case "description":
                    HTMLTextView(htmlContent: field.label)
                        .frame(height: 100)
                        .padding(.bottom, 5)
                    
                case "number":
                    TextField(field.label, value: $numberValue, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: numberValue) { newValue in
                            preferences.saveIntInputValue(filename: filename,fieldId: field.uuid, value: Int(newValue))
                        }
                        .onAppear {
                            numberValue = Double(preferences.getIntInputValue(filename: filename,fieldId: field.uuid) ?? 0)
                        }
                    
                case "dropdown":
                    if let options = field.options {
                        Picker(selection: $selectedIndex, label: Text(field.label)) {
                            ForEach(0..<options.count, id: \.self) { index in
                                Text(options[index].label).tag(index)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .onChange(of: selectedIndex) { newValue in
                            preferences.saveStringInputValue(filename: filename,fieldId: field.uuid, value: options[newValue].label)
                        }
                        .onAppear {
                            if let savedValue = preferences.getStringInputValue(filename: filename,fieldId: field.uuid),
                               let index = options.firstIndex(where: { $0.label == savedValue }) {
                                selectedIndex = index
                            }
                        }
                    }
                    
                default:
                    TextField(field.label, text: $textValue)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: textValue) { newValue in
                            preferences.saveStringInputValue(filename: filename,fieldId: field.uuid, value: newValue)
                        }
                        .onAppear {
                            textValue = preferences.getStringInputValue(filename: filename,fieldId: field.uuid) ?? ""
                        }
                }
            }
            
            Spacer()
            
            // Botão "X" para remover o campo
            Button(action: {
                removeField(field) // Chama a função para remover o campo
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.red)
                    .font(.title)
            }
        }
        .padding()
    }
}
