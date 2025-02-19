import SwiftUI

struct FormSectionView: View {
    let section: Section
    let filename: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(section.title)
                .font(.headline)
                .padding(.bottom, 5)
            }
    }
}
