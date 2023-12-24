//
//  Meal.swift
//  Recipes
//
//  Created by Raphael Iyin on 12/21/23.
//

import Foundation

struct Meal: Decodable, Hashable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
}

struct MealCategory: Decodable {
    let meals: [Meal]
}
