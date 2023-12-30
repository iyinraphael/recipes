//
//  NetworkService.swift
//  Recipes
//
//  Created by Raphael Iyin on 12/21/23.
//

import Foundation

class NetworkService {
    // MARK: - Private
    private var resource: (Data, URLResponse)?

    private func retrieveUrl(for parameters: [URLQueryItem], urlPath: String ) -> URL? {
        guard let baseURL = URL(string: urlPath) else { return nil }

        var urlComponent = URLComponents(url: baseURL, resolvingAgainstBaseURL: false)
        urlComponent?.queryItems = parameters

        return urlComponent?.url
    }
    
    private func fetchAPI<T>(from url: URLSearchType, with parameter: URLQueryItem) async -> Result<T, RecipeError> where T: Decodable {
        let parameters = [parameter]
        let urlPath = url.baseString
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
        guard let result = try? JSONDecoder().decode(T.self, from: data) else {
            return .failure(.decodeError)
        }
        return .success(result)
        
    }
    // MARK: - Internal
    func fetchMealCategory(category: String) async -> Result<MealCategory, RecipeError> {
        let parameter = URLQueryItem(name: "c", value: category)
        return await fetchAPI(from: .filterURL, with: parameter)
    }
    
    func fetctRecipes(mealID: String) async -> Result<Recipe, RecipeError> {
        let parameter = URLQueryItem(name: "i", value: mealID)
        return await fetchAPI(from: .idURL, with: parameter)
    }
}
