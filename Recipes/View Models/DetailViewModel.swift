//
//  DetailViewModel.swift
//  Recipes
//
//  Created by Raphael Iyin on 12/23/23.
//

import Foundation

class DetailViewModel: ObservableObject {
    let network: NetworkService
    @Published var mealId: String = ""
    weak var appCoordinator: AppCoordinator?
    
    init(network: NetworkService){
        self.network = network
    }
    func getRecipes() async -> Recipe {
        let result = await network.fetctRecipes(mealID: mealId)
        switch result {
        case .success(let recipe):
            return recipe
        case .failure(let error):
            fatalError("Could not retrieve meal recipes \(error)")
        }
    }
    func cleanIngredients(from recipes: [String: String?]) -> String {
           var ingredientsArray = [String]()
           
           for num in 1...20 {
               if let ingredient = recipes["strIngredient\(num)"],
                  let measurement = recipes["strMeasure\(num)"] {
                   ingredientsArray.append("\(measurement ?? " ") \(ingredient ?? " ")")

               }
           }
           
           return ingredientsArray
               .filter { $0 != " " }
               .reduce("**********", { x, y in
                   """
                   \(x)
                   \(y)
                   """
               })
       }
}
