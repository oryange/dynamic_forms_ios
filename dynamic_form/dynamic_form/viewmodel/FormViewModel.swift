import SwiftUI
import Foundation
import Combine

class FormViewModel: ObservableObject {
    
    @Published private var form: Form?
    var formLiveData: Form? { return form }
    
    private let repository = AssetFormRepository()
    private let preferences = FormLocalPreferences()
    
    private let jsonDecoder = JSONDecoder()
    private let jsonEncoder = JSONEncoder()
    
    
    func getFormSelected(filename: String) {
        if let fromCache = preferences.getFormToCache(filename: filename),
           let data = fromCache.data(using: .utf8) {
            do {
                let decodedForm = try jsonDecoder.decode(Form.self, from: data)
                self.form = decodedForm
            } catch {
                print("The error decoding the form from the cache:\(error)")
            }
        } else {
            if let fetchedForm = repository.getForm(filename: filename) {
                self.form = fetchedForm
                _ = preferences.saveFormToCache(filename: filename, form: fetchedForm)
            }
        }
    }
    
    @discardableResult
    func removeFieldToFormInCache(filename: String, removeField: Field? = nil, removeSection: Section? = nil) -> Bool {
        guard let formJson = preferences.getFormToCache(filename: filename),
              let data = formJson.data(using: .utf8) else { return false }
        
        do {
            var form = try jsonDecoder.decode(Form.self, from: data)
            
            var updatedFields = form.fields
            var updatedSections = form.sections
            
            if let fieldToRemove = removeField {
                updatedFields.removeAll { $0.uuid == fieldToRemove.uuid }
            }
            
            if let sectionToRemove = removeSection {
                updatedSections.removeAll { $0.uuid == sectionToRemove.uuid }
            }
            
            let updatedForm = Form(title: form.title,fields: updatedFields, sections: updatedSections)
            self.form = updatedForm
            
            return preferences.saveFormToCache(filename: filename, form: updatedForm)
        } catch {
            print("Error decoding the form:\(error)")
            return false
        }
    }
    
    func saveInputValue(filename: String, fieldId: String, value: String) {
        preferences.saveStringInputValue(filename: filename, fieldId: fieldId, value: value)
    }
    
    func saveIntInputValue(filename: String, fieldId: String, value: Int) {
        preferences.saveIntInputValue(filename: filename, fieldId: fieldId, value: value)
    }
    
    func saveDropdownValue(filename: String, fieldId: String, selectedIndex: Int) {
        preferences.saveDropdownValue(filename: filename, fieldId: fieldId, selectedIndex: selectedIndex)
    }
    
    func getInputValue(filename: String, fieldId: String) -> String {
        return preferences.getStringInputValue(filename: filename, fieldId: fieldId) ?? ""
    }
    
    func getIntInputValue(filename: String, fieldId: String) -> Int {
        return preferences.getIntInputValue(filename: filename, fieldId: fieldId) ?? 0
    }
    
    func getDropdownValue(filename: String, fieldId: String) -> Int {
        return preferences.getDropdownValue(filename: filename, fieldId: fieldId)
    }
    
    func clearForm(filename: String) {
        preferences.clearInputValues(filename: filename)
        getFormSelected(filename: filename)
    }
}
