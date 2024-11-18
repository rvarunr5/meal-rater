//
//  Meal.swift
//  MealRater
//
//  Created by Varun Reddy Regalla on 11/17/24.
//

import Foundation
import CoreData

class MealStore: ObservableObject {
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "MealRater")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    func saveMeal(restaurant: String, dish: String, rating: Int) {
        let meal = Meal(context: container.viewContext)
        meal.id = UUID()
        meal.restaurant = restaurant
        meal.dish = dish
        meal.rating = Int16(rating)
        meal.date = Date()
        
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving meal: \(error.localizedDescription)")
        }
    }
    
    func fetchMeals() -> [Meal] {
        let request = NSFetchRequest<Meal>(entityName: "Meal")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Meal.date, ascending: false)]
        
        do {
            return try container.viewContext.fetch(request)
        } catch {
            print("Error fetching meals: \(error.localizedDescription)")
            return []
        }
    }
}
