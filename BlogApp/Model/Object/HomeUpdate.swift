//
//  HomeUpdate.swift
//  BlogApp
//
//  Created by Lior Dorenboust on 12/03/2021.
//
//  use to get all the parameters from 'HomeModel' Result<>func to HomeViewController

import Foundation
struct HomeUpdate {
    var categories: [Category]?
    var articels: [Article]?
    var authors: [Author]?
}
