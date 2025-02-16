import Foundation

class AssetFormRepository: FormDataSource {
    let bundle: Bundle
    
    init(bundle: Bundle = .main) {
        self.bundle = bundle
    }
    
    private func loadJsonFromAssets(fileName: String) -> String? {
        guard let path = bundle.path(forResource: fileName, ofType: "json") else {
            print("File \(fileName).json not found in bundle")
            return nil
        }
        print("File path found: \(path)")
        
        do {
            let json = try String(contentsOfFile: path, encoding: .utf8)
            return json
        } catch {
            print("Error loading file \(fileName): \(error)")
            return nil
        }
    }
    
    func getForm(filename: String) -> Form? {
        guard let json = loadJsonFromAssets(fileName: filename) else {
            return nil
        }
        
        let decoder = JSONDecoder()
        guard let data = json.data(using: .utf8) else {
            print("Error converting JSON string to data")
            return nil
        }
        
        do {
            let form = try decoder.decode(Form.self, from: data)
            return form
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}
