//
//  NetworkService.swift
//  Recipes
//
//  Created by Raphael Iyin on 12/21/23.
//

import Foundation

class NetworkService {
    private func retrieveUrl(for parameters: [URLQueryItem], urlPath: String ) -> URL? {
        guard let baseURL = URL(string: urlPath) else { return nil }

        var urlComponent = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        urlComponent?.queryItems = parameters

        return urlComponent?.url
    }
    
    func fetchMealCategory(urlRecipe: URLRecipeType, mealId: String) async throws -> MealCategory {
        let parameters = [URLQueryItem(name: "c", value: mealId)]
        let urlPath = urlRecipe.baseString
        guard let url = retrieveUrl(for: parameters, urlPath: urlPath) else {
            throw RecipeError.otherError
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        print(data)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw RecipeError.networkError
        }
        guard let category = try? JSONDecoder().decode(MealCategory.self, from: data) else {
            throw RecipeError.decodeError
        }
        return category
    }
    
}
