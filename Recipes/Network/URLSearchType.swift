//
//  URLRecipeType.swift
//  Recipes
//
//  Created by Raphael Iyin on 12/21/23.
//

import Foundation

enum URLSearchType {
    // MARK: - Private
    private static let urlString = "https://themealdb.com/api/json/v1/1"
    
    //MARK: - Public
    case filterURL
    case idURL
    
    var baseString: String {
        switch self {
        case .filterURL:
            return "\(Self.urlString)/filter.php"
        case .idURL:
            return "\(Self.urlString)/lookup.php"
        }
    }
}
