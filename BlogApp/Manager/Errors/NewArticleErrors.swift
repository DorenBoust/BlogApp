//
//  GFError.swift
//  BlogApp
//
//  Created by Lior Dorenboust on 06/03/2021.
//

import Foundation

enum NewArticleErrors: String, Error {
    case unableToComplate = "unableToComplate"
    case invalidData = "invalidData"
    case invalidResponse = "invalidResponse"
    case invalidURL = "invalidURL"
}

enum ArticelsByCategoryError: String, Error {
    case unableToComplate = "unableToComplate"
    case invalidData = "invalidData"
    case invalidResponse = "invalidResponse"
    case invalidURL = "invalidURL"
    case notFoundCategoryName = "notFoundCategoryName"
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

enum HomeUpdateErrors: String, Error {
    case articelsFailed = "articelsFailed"
    case categoriesFailed = "categoriesFailed"
    case authorsFailed = "authorsFailed"
}
