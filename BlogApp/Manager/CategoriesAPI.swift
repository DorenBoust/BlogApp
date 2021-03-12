//
//  CategoriesAPI.swift
//  BlogApp
//
//  Created by Lior Dorenboust on 12/03/2021.
//

import Foundation
import SwiftyJSON

struct CategoriesAPI {
    static let shared = CategoriesAPI()
    private init(){}
    
    //MARK: - properties
    private let baseCategoriesImagesAPI = "https://blogapp.boust.me/wp-json/acf/v3/categories_images"

    //MARK: - public func
    public func getCategoriesImages(complited: @escaping (Result<[Category], CategoriesImagesErrors>)->Void){
        guard let getCategoriesImagesURL = URL(string: self.baseCategoriesImagesAPI) else {
            complited(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: getCategoriesImagesURL) { (data, ress, error) in
            
            if let _ = error {
                complited(.failure(.unableToComplate))
                return
            }
            
            guard let data = data else {
                complited(.failure(.invalidData))
                return
            }
            
            let rootJSON = (JSON(data).first?.1)!
            let acfJSON = rootJSON["acf"]
            let categoriesImagesJSON = acfJSON["categories_images"]
            let numberOfCategories = Int(categoriesImagesJSON["number_of_categories"].stringValue)!
            
            var categories: [Category] = []
            for i in 0 ..< numberOfCategories {
                let categoryNumber = "category\(i+1)"
                let categoriesJSON = categoriesImagesJSON["Categories"]
                
                let categoryObjectJSON = categoriesJSON[categoryNumber]
                let name = categoryObjectJSON["category"].stringValue
                let image = categoryObjectJSON["category_image"].stringValue
                
                categories.append(Category(name: name, image: image, articles: nil))
            }
            
            complited(.success(categories))
            return
        }.resume()
    }
}
