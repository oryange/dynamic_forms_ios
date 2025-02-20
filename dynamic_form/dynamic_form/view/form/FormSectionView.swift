import SwiftUI

struct FormSectionView: View {
    let section: Section
    let filename: String
    let removeSection: (Section) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(section.title)
                    .font(.headline)
                    .padding(.bottom, 5)
                
                Spacer()
                
                Button(action: {
                    removeSection(section)
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.red)
                        .font(.title)
                }
            }
            .padding(.bottom, 5)
        }
        .padding()
    }
}
