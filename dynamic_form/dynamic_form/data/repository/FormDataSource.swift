import Foundation

protocol FormDataSource {
    func getForm(filename: String) -> Form?
}
