
import Foundation

protocol FormPreferences {
    func saveFormToCache(filename: String, form: Form) -> Bool
    func getFormToCache(filename: String) -> String?
    func saveStringInputValue(fieldId: String, value: String)
    func getStringInputValue(fieldId: String) -> String?
    func saveIntInputValue(fieldId: String, value: Int)
    func getIntInputValue(fieldId: String) -> Int?
    func saveDropdownValue(fieldId: String, selectedIndex: Int)
    func getDropdownValue(fieldId: String) -> Int
    func clearInputValues()
}
