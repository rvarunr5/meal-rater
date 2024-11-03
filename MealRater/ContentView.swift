import SwiftUI

struct ContentView: View {
    @State private var restaurantName: String = ""
    @State private var dishName: String = ""
    @State private var rating: Int = 0
    @State private var showingRatingSheet = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Restaurant Input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Restaurant")
                            .font(.headline)
                        TextField("Enter restaurant name", text: $restaurantName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    // Dish Input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Dish")
                            .font(.headline)
                        TextField("Enter dish name", text: $dishName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    
                    // Rating Display
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Rating")
                            .font(.headline)
                        HStack {
                            if rating == 0 {
                                Text("Not rated yet")
                                    .foregroundStyle(.secondary)
                            } else {
                                HStack(spacing: 4) {
                                    Text("\(rating)")
                                        .font(.title2)
                                        .bold()
                                    ForEach(1...rating, id: \.self) { _ in
                                        Image(systemName: "star.fill")
                                            .foregroundStyle(.yellow)
                                    }
                                }
                            }
                        }
                        .frame(height: 44)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .background(.quaternary)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    // Rate Button
                    Button(action: {
                                            showingRatingSheet = true
                                        }) {
                                            HStack {
                                                Image(systemName: "star")
                                                    .imageScale(.medium)
                                                Text("Rate Meal")
                                                    .fontWeight(.medium)
                                            }
                                            .frame(height: 44)
                                            .frame(maxWidth: .infinity)
                                            .background(Color(red: 0.4, green: 0.6, blue: 1.0))
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                        }
                }
                .padding()
            }
            .navigationTitle("MealRater")
            .sheet(isPresented: $showingRatingSheet) {
                RatingView(rating: $rating)
            }
        }
    }
}

#Preview {
    ContentView()
}
