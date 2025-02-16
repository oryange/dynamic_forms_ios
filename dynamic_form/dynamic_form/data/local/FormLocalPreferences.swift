import Foundation

class FormSharedPreferences: FormPreferences {
    
    private let userDefaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func saveFormToCache(filename: String, form: Form) -> Bool {
        if let data = try? encoder.encode(form) {
            userDefaults.set(data, forKey: filename)
            return true
        }
        return false
    }

    func getFormToCache(filename: String) -> String? {
        guard let data = userDefaults.data(forKey: filename),
              let form = try? decoder.decode(Form.self, from: data) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    func saveStringInputValue(fieldId: String, value: String) {
        userDefaults.set(value, forKey: "input_\(fieldId)")
    }
    
    func getStringInputValue(fieldId: String) -> String? {
        return userDefaults.string(forKey: "input_\(fieldId)")
    }

    func saveIntInputValue(fieldId: String, value: Int) {
        userDefaults.set(value, forKey: "input_\(fieldId)")
    }

    func getIntInputValue(fieldId: String) -> Int? {
        return userDefaults.integer(forKey: "input_\(fieldId)")
    }

    func saveDropdownValue(fieldId: String, selectedIndex: Int) {
        userDefaults.set(selectedIndex, forKey: "dropdown_\(fieldId)")
    }

    func getDropdownValue(fieldId: String) -> Int {
        return userDefaults.integer(forKey: "dropdown_\(fieldId)")
    }

    func clearInputValues() {
        let keysToRemove = userDefaults.dictionaryRepresentation().keys.filter {
            $0.hasPrefix("input_") || $0.hasPrefix("dropdown_")
        }
        
        keysToRemove.forEach { userDefaults.removeObject(forKey: $0) }
    }
}
