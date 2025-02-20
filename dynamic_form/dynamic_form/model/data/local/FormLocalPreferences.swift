import Foundation

class FormLocalPreferences: FormPreferences {
    
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
    
    func saveStringInputValue(filename:String, fieldId: String, value: String) {
        userDefaults.set(value, forKey: "\(filename)_input_\(fieldId)")
    }
    
    func getStringInputValue(filename:String, fieldId: String) -> String? {
        return userDefaults.string(forKey: "\(filename)_input_\(fieldId)")
    }
    
    func saveIntInputValue(filename:String, fieldId: String, value: Int) {
        userDefaults.set(value, forKey: "\(filename)_input_\(fieldId)")
    }
    
    func getIntInputValue(filename:String, fieldId: String) -> Int? {
        return userDefaults.integer(forKey: "\(filename)_input_\(fieldId)")
    }
    
    func saveDropdownValue(filename:String, fieldId: String, selectedIndex: Int) {
        userDefaults.set(selectedIndex, forKey: "\(filename)_dropdown_\(fieldId)")
    }
    
    func getDropdownValue(filename:String, fieldId: String) -> Int {
        return userDefaults.integer(forKey: "\(filename)_dropdown_\(fieldId)")
    }
    
    
    func getAllInputValuesFromCache(filename: String) -> [String: Any] {
        return userDefaults.dictionaryRepresentation()
    }
    
    func clearInputValues(filename: String) {
        let allValues = getAllInputValuesFromCache(filename: filename)
        let keysToRemove = allValues.keys.filter {
            $0.contains("\(filename)_input_") || $0.contains("\(filename)_dropdown_")
        }
        
        for key in keysToRemove {
            userDefaults.removeObject(forKey: key)
        }
        
        userDefaults.synchronize()
    }
}

