import SwiftUI

struct FormView: View {
    var formType: String
    
    var body: some View {
        Text("Hello, World! - \(formType)")
            .font(.largeTitle)
            .padding()
    }
}
