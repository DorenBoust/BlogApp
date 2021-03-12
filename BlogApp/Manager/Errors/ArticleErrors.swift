//
//  GFError.swift
//  BlogApp
//
//  Created by Lior Dorenboust on 06/03/2021.
//

import Foundation

enum ArticleErrors: String, Error {
    case unableToComplate = "unableToComplate"
    case invalidData = "invalidData"
    case invalidResponse = "invalidResponse"
    case invalidURL = "invalidURL"
}

enum AuthorImagesErrors: String, Error {
    case unableToComplate = "unableToComplate"
    case invalidData = "invalidData"
    case invalidResponse = "invalidResponse"
    case invalidURL = "invalidURL"
}

enum CategoriesImagesErrors: String, Error {
    case unableToComplate = "unableToComplate"
    case invalidData = "invalidData"
    case invalidResponse = "invalidResponse"
    case invalidURL = "invalidURL"
}
