import SwiftUI

struct FormFieldView: View {
    let field: Field
    var body: some View {
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
                TextField(field.label, value: .constant(0), formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

            case "dropdown":
                if let options = field.options {
                    Picker(selection: .constant(0), label: Text(field.label)) {
                        ForEach(0..<options.count, id: \.self) { index in
                            Text(options[index].label).tag(index)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                }
            default:
                TextField(field.label, text: .constant(""))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        .padding()
    }
}
