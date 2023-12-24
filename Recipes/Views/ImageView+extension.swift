//
//  ImageView+extension.swift
//  Recipes
//
//  Created by Raphael Iyin on 12/23/23.
//

import UIKit

extension UIImageView {
    func loadImage(from imageStr: String) async {
        let imageCache = NSCache<NSString, AnyObject>()
        if let cachedImage = imageCache.object(forKey: imageStr as NSString) as?  UIImage {
            self.image = cachedImage
        } else {
            let imgData = await ImageLoader.downloadImage(imageStr: imageStr)
            guard let imgToCatch = try? UIImage(data: imgData.get()) else {
                fatalError("\(RecipeError.noDataError)")
            }
            imageCache.setObject(imgToCatch, forKey: imageStr as NSString)
            DispatchQueue.main.async {
                self.image = imgToCatch
            }
        }
    }
}
