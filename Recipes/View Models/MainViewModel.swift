//
//  MainViewModel.swift
//  Recipes
//
//  Created by Raphael Iyin on 12/21/23.
//

import Foundation

class MainViewModel {
    private let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func getAll() async {
        do {
            let recipe = try await networkService.fetchMealCategory(urlRecipe: .filterURL, mealId: "Dessert")
            print(recipe)
        } catch let error {
            print(error)
        }
    }
}
