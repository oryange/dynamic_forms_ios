
import Foundation

protocol FormPreferences {
    func saveFormToCache(filename: String, form: Form) -> Bool
    func getFormToCache(filename: String) -> String?
    func saveStringInputValue(filename: String,fieldId: String, value: String)
    func getStringInputValue(filename: String,fieldId: String) -> String?
    func saveIntInputValue(filename: String,fieldId: String, value: Int)
    func getIntInputValue(filename: String,fieldId: String) -> Int?
    func saveDropdownValue(filename: String,fieldId: String, selectedIndex: Int)
    func getDropdownValue(filename: String,fieldId: String) -> Int
    func clearInputValues(filename: String)
}
