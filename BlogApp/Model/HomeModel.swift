//
//  HomeModel.swift
//  BlogApp
//
//  Created by Lior Dorenboust on 12/03/2021.
//

import Foundation
struct HomeModel {
    
    static let shared = HomeModel()
    private init(){}
    
    //MARK: - properties
    
    //MARK: - public funcs
    
    // when the app just init or need to refrash to get the new articels. get the categories/newArticel/authors
    public func updateArticels(callback: @escaping (Result<HomeUpdate, HomeUpdateErrors>)->Void){
        // get categories
        CategoriesAPI.shared.getCategoriesImages { (categoriesResultes) in
            switch categoriesResultes {
            case .success(let categories):
                //get articels
                ArticleAPI.shared.getNewArticals { (articelsResultes) in
                    switch articelsResultes {
                    case .success(let articels):
                        print("articels home: \(articels)")
                        // get authors
                        AuthorAPI.shared.getAuthors { (authorsResulters) in
                            switch authorsResulters {
                            case .success(let authors):
                                callback(.success(HomeUpdate(categories: categories, articels: articels, authors: authors)))
                                return
                                
                            case .failure(let error):
                                print("AuthorAPI error: \(error)")
                                callback(.failure(.authorsFailed))
                                return
                            }
                        }
                        
                    case .failure(let error):
                        print("ArticleAPI error: \(error)")
                        callback(.failure(.articelsFailed))
                        return
                    }
                }
                
                
            case .failure(let error):
                print("CategoriesAPI error: \(error)")
                callback(.failure(.categoriesFailed))
                return
            }
        }
    }
    
    //MARK: - praivate funcs
    
}
