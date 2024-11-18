//
//  MealRaterApp.swift
//  MealRater
//
//  Created by Varun Reddy Regalla on 11/3/24.
//

import SwiftUI

@main
struct MealRaterApp: App {
    @StateObject private var mealStore = MealStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(mealStore)
        }
    }
}
