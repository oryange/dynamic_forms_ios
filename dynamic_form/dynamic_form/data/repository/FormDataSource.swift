import Foundation

protocol FormDataSource {
    func getForm(fileName: String) -> Form?
}
