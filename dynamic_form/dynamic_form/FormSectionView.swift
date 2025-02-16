import SwiftUI

struct FormSectionView: View {
    let section: Section
    var body: some View {
        VStack(alignment: .leading) {
            Text(section.title)
                .font(.headline)
                .padding(.bottom, 5)
            }
    }
}
