//
//  MainViewModel.swift
//  Recipes
//
//  Created by Raphael Iyin on 12/21/23.
//

import Foundation

enum CategoryType: String, CaseIterable {
    case starter = "Starter"
    case pasta = "Pasta"
    case dessert = "Dessert"
    
    static func allValues() -> [String] {
               return self.allCases.map { $0.rawValue }
           }
}

final class MainViewModel {
    private let networkService: NetworkService
    private(set) var meals = [Meal]()
    
    weak var appCoordinator: AppCoordinator?
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    func getAllMeals(category: CategoryType) async {
        let result = await networkService.fetchMealCategory(category: category.rawValue)
        switch result {
        case .success(let meals):
            self.meals = meals.meals
        case .failure(let error):
            print(error)
        }
    }
}
