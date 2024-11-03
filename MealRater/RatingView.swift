import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    @Environment(\.dismiss) var dismiss
    @State private var selectedRating: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("How was your meal?")
                    .font(.title2)
                    .bold()
                    .padding(.top, 20)
                
                // Rating Buttons
                HStack(spacing: 12) {
                    ForEach(1...5, id: \.self) { number in
                        RatingButton(
                            number: number,
                            isSelected: selectedRating >= number,
                            action: { selectedRating = number }
                        )
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        rating = selectedRating
                        dismiss()
                    }
                    .disabled(selectedRating == 0)
                    .tint(selectedRating == 0 ? .secondary : .blue)
                }
            }
        }
    }
}

#Preview {
    RatingView(rating: .constant(0))
}
