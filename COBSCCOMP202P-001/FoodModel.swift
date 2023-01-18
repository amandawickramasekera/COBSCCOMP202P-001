//
//  FoodModel.swift
//  COBSCCOMP202P-001
//
//  Created by Amanda Wickramasekera on 2023-01-17.
//

import Foundation

class FoodModel{
    
    var calories: Int?
    var foodName: String?
    var ingredients: String?
    
    init(calories: Int, foodName: String, ingredients: String) {
        self.calories = calories
        self.ingredients = ingredients
        self.foodName = foodName
    }
}
