//
//  APIServiceError.swift
//  Recipes
//
//  Created by Raphael Iyin on 12/21/23.
//

import Foundation

enum RecipeError: Error {
    case decodeError
    case networkError
    case noDataError
    case otherError
}
