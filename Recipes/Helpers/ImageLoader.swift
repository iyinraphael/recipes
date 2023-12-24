//
//  ImageLoader.swift
//  Recipes
//
//  Created by Raphael Iyin on 12/23/23.
//

import Foundation

class ImageLoader {
    static func downloadImage(imageStr: String) async -> Result<Data, RecipeError> {
        guard let imageUrl = URL(string: imageStr),
              let (data, _) = try? await URLSession.shared.data(from: imageUrl) else {
            return .failure(.otherError)
        }
        return .success(data)
    }
}
