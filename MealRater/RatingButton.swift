import SwiftUI

struct RatingButton: View {
    let number: Int
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: isSelected ? "star.fill" : "star")
                    .font(.system(size: 24))
                    .foregroundStyle(isSelected ? .yellow : .secondary)
                
                Text("\(number)")
                    .font(.caption)
                    .bold()
                    .foregroundStyle(isSelected ? .primary : .secondary)
            }
            .frame(width: 60, height: 60)
            .background(isSelected ? Color.gray.opacity(0.2) : Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .buttonStyle(.scale)
    }
}

// Custom button style for scaling effect
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

// Extension to make the button style easier to use
extension ButtonStyle where Self == ScaleButtonStyle {
    static var scale: ScaleButtonStyle {
        ScaleButtonStyle()
    }
}

#Preview {
    HStack {
        RatingButton(number: 1, isSelected: false, action: {})
        RatingButton(number: 2, isSelected: true, action: {})
    }
    .padding()
}
