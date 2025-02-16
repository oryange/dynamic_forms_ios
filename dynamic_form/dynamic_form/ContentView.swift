import SwiftUI

struct ContentView: View {
    @State private var form: Form? = nil
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Choose your preferred form")
                    .font(.title)
                    .foregroundColor(.gray)
                    .padding(.top, 20)
                
                HStack(spacing: 16) {
                    NavigationLink(destination: FormViewController(formType: "FORM_ONE")) {
                        Text("Form One")
                            .buttonStyle()
                    }
                    
                    NavigationLink(destination: FormViewController(formType: "FORM_TWO")) {
                        Text("Form Two")
                            .buttonStyle()
                    }
                }
                .padding(.top, 10)
                
                Spacer()
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Dynamic Forms")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
        }
    }
}

extension View {
    func buttonStyle() -> some View {
        self
            .frame(maxWidth: .infinity)
            .padding(15)
            .font(.system(size: 20, weight: .bold))
            .background(Color.purple.opacity(0.8))
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

#Preview {
    ContentView()
}
