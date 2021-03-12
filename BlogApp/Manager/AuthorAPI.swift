//
//  AuthorAPI.swift
//  BlogApp
//
//  Created by Lior Dorenboust on 12/03/2021.
//

import Foundation
import SwiftyJSON

struct AuthorAPI {
    static let shared = AuthorAPI()
    private init(){}
    
    //MARK: - properties
    private let baseAuthorAPI = "https://blogapp.boust.me/wp-json/acf/v3/author_images"
    
    //MARK: - public func
    public func getAuthors(complited: @escaping (Result<[Author], ArticleErrors>)->Void){
        guard let getAutherURL = URL(string: self.baseAuthorAPI) else {
            complited(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: getAutherURL) { (data, ress, error) in
            
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
            let authorImagesJSON = acfJSON["author_images"]
            let numberOfAuthors = Int(authorImagesJSON["number_of_author"].stringValue)!
            var authors: [Author] = []
            
            for i in 0 ..< numberOfAuthors {
                let authorNumber = "author\(i+1)"
                let authorsJSON = authorImagesJSON["authors"]
                let authorJSON = authorsJSON[authorNumber]
                let image = authorJSON["author_image"].stringValue
                
                let authorObjectJSON = authorJSON["author"]
                let name = authorObjectJSON["nickname"].stringValue
                
                authors.append(Author(name: name, image: image))
            }
            
            complited(.success(authors))
            return
        }.resume()
    }
}
