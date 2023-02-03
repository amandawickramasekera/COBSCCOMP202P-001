//
//  FoodModel.swift
//  COBSCCOMP202P-001
//
//  Created by Amanda Wickramasekera on 2023-01-17.
//

import Foundation

class FoodModel{
    
    var calories: Int?
    var calorieBreakdown : String?
    var foodName: String?
    var ingredients: String?
    var otherNutrients: String?
    
    init(calories: Int, calorieBreakdown: String, foodName: String, ingredients: String, otherNutrients: String) {
        self.calories = calories
        self.calorieBreakdown = calorieBreakdown
        self.ingredients = ingredients
        self.foodName = foodName
        self.otherNutrients = otherNutrients
    }
}
