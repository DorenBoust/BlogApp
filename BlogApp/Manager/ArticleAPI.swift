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
    public func getArticals(complited: @escaping (Result<[Article], ArticleErrors>)->Void){
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
                
                articles.append(Article(id: id, date: date, link: link, title: title, content: content, categotys: categories))
            }
            
            complited(.success(articles))
            return
        }.resume()
    }

    //MARK: - praivte func
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

}
