import Foundation

class FormEntriesViewModel: ObservableObject {
    @Published var formFields: [Field] = []
    @Published var formSections: [Section] = []
    
    private let preferences = FormLocalPreferences()
    
    
    func addSection(formSelected: String, name: String) -> Bool {
        let newSection = Section(
            title: name,
            from:nil,
            to: nil,
            index:nil,
            uuid: "\(formSelected)_input_\(UUID().uuidString)"
        )
        return addFieldToFormInCache(
            filename: formSelected,
            newSection: newSection
        )
    }
    
    func addField(formSelected: String, type: String, label: String, name: String, required: Bool) -> Bool {
        let newField = Field(
            type: type,
            label: label,
            name: name,
            required: required,
            uuid: "\(formSelected)_input_\(UUID().uuidString)",
            options: nil
        )
        return addFieldToFormInCache(
            filename: formSelected,
            newField: newField
        )
    }
    
    
    func addFieldToFormInCache(filename: String, newField: Field? = nil, newSection: Section? = nil) -> Bool {
        guard let formJson = preferences.getFormToCache(filename: filename),
              let formData = formJson.data(using: .utf8) else {
            return false
        }
        
        do {
            var form = try JSONDecoder().decode(Form.self, from: formData)
            
            if let newField = newField {
                form.fields.insert(newField, at: 0)
            }
            if let newSection = newSection {
                form.sections.insert(newSection, at: 0)
            }
            
            return preferences.saveFormToCache(filename: filename, form: form)
        } catch {
            print("Erro ao atualizar o formulário: \(error)")
            return false
        }
    }
}
