//
//  ArticleAPI.swift
//  BlogApp
//
//  Created by Lior Dorenboust on 06/03/2021.
//

import Foundation
import SwiftyJSON

struct ArticleAPI {
    
    static let shared = ArticleAPI()
    private init(){}
    
    //MARK: - properties
    private let baseArticleAPI = "https://blogapp.boust.me/wp-json/wp/v2/posts"

    //MARK: - public func
    public func getNewArticals(complited: @escaping (Result<[Article], NewArticleErrors>)->Void){
        guard let getArticalsURL = URL(string: self.baseArticleAPI) else {
            complited(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: getArticalsURL) { (data, ress, error) in
            
            if let _ = error {
                complited(.failure(.unableToComplate))
                return
            }
            
            guard let data = data else {
                complited(.failure(.invalidData))
                return
            }
  
            if let articels = self.dataToArticel(data: data) {
                complited(.success(articels))
                return
            } else {
                complited(.failure(.invalidData))
                return
            }
            
            
//            let articlesJSON = JSON(data)
//            var articles: [Article] = []
//
//            for article in articlesJSON {
//                let json = article.1
//                let id = json["id"].int
//                let date = json["date"].stringValue
//                let link = json["link"].stringValue
//
//                let titleJson = json["title"]
//                let title = titleJson["rendered"].stringValue
//
//                let contentJSON = json["content"]
//                let content = contentJSON["rendered"].stringValue
//
//                let categoriesJSON = json["categories"]
//                var categories: [String]? = []
//
//                for catogory in categoriesJSON {
//                    let categoryNumber = catogory.1.int
//                    if let categoryName = self.categoryNumberToName(categoryNumber: categoryNumber) {
//                        categories?.append(categoryName)
//                    }
//                }
//
//                let acfFieldsJSON = json["acf"] // get here description+innerImage+outerImage+authorName
//                let description = acfFieldsJSON["description"].stringValue
//                let innerImage = acfFieldsJSON["inner_image"].stringValue
//                let outerImage = acfFieldsJSON["outer_image"].stringValue
//
//                let authorJSON = acfFieldsJSON["author"]
//                let authorDataJSON = authorJSON["data"]
//                let authorName = authorDataJSON["display_name"].stringValue
//
//
//                articles.append(Article(id: id, date: date, link: link, title: title, authorName: authorName, description: description, outerImage: outerImage, innerImage: innerImage, content: content, categotys: categories))
//            }
//
//            complited(.success(articles))
//            return
        }.resume()
    }
    
    public func getArticelsByCategory(categoryName: String, callback: @escaping (Result<[Article], ArticelsByCategoryError>)->Void){
        
        
        var urlComponents = URLComponents(string: self.baseArticleAPI)
        guard let categoryNumber = self.categoryNameToNumber(categoryName: categoryName) else {
            callback(.failure(.notFoundCategoryName))
            return
        }
        let params = ["categories": String(categoryNumber)]
        
        
        let query = params.map(URLQueryItem.init)
        
        urlComponents?.queryItems = query
        
        guard let url = urlComponents?.url else {
            callback(.failure(.invalidURL))
            return
        }
        
        
        URLSession.shared.dataTask(with: url) { (data, ress, error) in
            if let _ = error {
                callback(.failure(.unableToComplate))
                return
            }
            
            guard let data = data else {
                callback(.failure(.invalidData))
                return
            }
            
            if let articels = self.dataToArticel(data: data) {
                callback(.success(articels))
                return
            } else {
                callback(.failure(.invalidData))
                return
            }
            
        }.resume()
        
    }

    //MARK: - praivte func
    private func dataToArticel(data: Data)->[Article]?{
        let articlesJSON = JSON(data)
        var articles: [Article] = []
        
        for article in articlesJSON {
            let json = article.1
            let id = json["id"].int
            let date = json["date"].stringValue
            let link = json["link"].stringValue
            
            let titleJson = json["title"]
            let title = titleJson["rendered"].stringValue
            
            let contentJSON = json["content"]
            let content = contentJSON["rendered"].stringValue
            
            let categoriesJSON = json["categories"]
            var categories: [String]? = []
            
            for catogory in categoriesJSON {
                let categoryNumber = catogory.1.int
                if let categoryName = self.categoryNumberToName(categoryNumber: categoryNumber) {
                    categories?.append(categoryName)
                }
            }
            
            let acfFieldsJSON = json["acf"] // get here description+innerImage+outerImage+authorName
            let description = acfFieldsJSON["description"].stringValue
            let innerImage = acfFieldsJSON["inner_image"].stringValue
            let outerImage = acfFieldsJSON["outer_image"].stringValue
            
            let authorJSON = acfFieldsJSON["author"]
            let authorDataJSON = authorJSON["data"]
            let authorName = authorDataJSON["display_name"].stringValue
            
            
            articles.append(Article(id: id, date: date, link: link, title: title, authorName: authorName, description: description, outerImage: outerImage, innerImage: innerImage, content: content, categotys: categories))
        }
        
        return articles
    }
    
    private func categoryNumberToName(categoryNumber: Int?) -> String?{
        switch categoryNumber {
        case 2:
            return "תרבות"
        case 3:
            return "ספורט"
        case 4:
            return "פוליטי"
        case 5:
            return "מדיני"
        default:
            return nil
        }
    }
    
    private func categoryNameToNumber(categoryName: String?) -> Int?{
        switch categoryName {
        case "תרבות":
            return 2
        case "ספורט":
            return 3
        case "פוליטי":
            return 4
        case "מדיני":
            return 5
        default:
            return nil
        }
    }

}
