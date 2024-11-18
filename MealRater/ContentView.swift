import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var mealStore = MealStore()
    @State private var restaurantName: String = ""
    @State private var dishName: String = ""
    @State private var rating: Int = 0
    @State private var showingRatingSheet = false
    @State private var showingSaveAlert = false
    @State private var savedMeals: [Meal] = []
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Restaurant Input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Restaurant")
                            .font(.headline)
                        TextField("Enter restaurant name", text: $restaurantName)
                            .textFieldStyle(CustomTextFieldStyle())
                    }
                    
                    // Dish Input
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Dish")
                            .font(.headline)
                        TextField("Enter dish name", text: $dishName)
                            .textFieldStyle(CustomTextFieldStyle())
                    }
                    
                    // Rating Display
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Rating")
                            .font(.headline)
                        HStack {
                            if rating == 0 {
                                Text("Not rated yet")
                                    .foregroundColor(.secondary)
                            } else {
                                HStack(spacing: 4) {
                                    Text("\(rating)")
                                        .font(.title2)
                                        .bold()
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                }
                            }
                        }
                        .frame(height: 44)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .background(.gray.opacity(0.1))
                        .cornerRadius(8)
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
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    
                    // Save Button
                    Button(action: saveMeal) {
                        HStack {
                            Image(systemName: "square.and.arrow.down")
                                .imageScale(.medium)
                            Text("Save Rating")
                                .fontWeight(.medium)
                        }
                        .frame(height: 44)
                        .frame(maxWidth: .infinity)
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                    .disabled(restaurantName.isEmpty || dishName.isEmpty || rating == 0)
                    
                    // Saved Meals List
                    if !savedMeals.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Previous Ratings")
                                .font(.headline)
                            
                            ForEach(savedMeals) { meal in
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(meal.restaurant ?? "")
                                            .font(.headline)
                                        Text(meal.dish ?? "")
                                            .font(.subheadline)
                                    }
                                    Spacer()
                                    HStack {
                                        Text("\(meal.rating)")
                                        Image(systemName: "star.fill")
                                            .foregroundColor(.yellow)
                                    }
                                }
                                .padding()
                                .background(.gray.opacity(0.1))
                                .cornerRadius(8)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("MealRater")
            .sheet(isPresented: $showingRatingSheet) {
                RatingView(rating: $rating)
            }
            .alert("Rating Saved", isPresented: $showingSaveAlert) {
                Button("OK", role: .cancel) { }
            }
        }
        .onAppear {
            savedMeals = mealStore.fetchMeals()
        }
    }
    
    private func saveMeal() {
        mealStore.saveMeal(
            restaurant: restaurantName,
            dish: dishName,
            rating: rating
        )
        
        // Clear the form
        restaurantName = ""
        dishName = ""
        rating = 0
        
        // Show confirmation and update saved meals
        showingSaveAlert = true
        savedMeals = mealStore.fetchMeals()
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(.white)
            .cornerRadius(8)
            .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)
    }
}
