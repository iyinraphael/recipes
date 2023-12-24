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
    
    func fetchMealCategory(urlRecipe: URLRecipeType, category: String) async -> Result<MealCategory, RecipeError> {
        var resource: (Data, URLResponse)?
        let parameters = [URLQueryItem(name: "c", value: category)]
        let urlPath = urlRecipe.baseString
        guard let url = retrieveUrl(for: parameters, urlPath: urlPath) else {
            return .failure(.otherError)
        }
        resource = try? await URLSession.shared.data(from: url)
        guard let (data, response) = resource else {
            return .failure(.noDataError)
        }
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            return .failure(.networkError)
        }
        guard let category = try? JSONDecoder().decode(MealCategory.self, from: data) else {
            return .failure(.decodeError)
        }
        return .success(category)
    }
}
