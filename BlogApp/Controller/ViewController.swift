//
//  ViewController.swift
//  BlogApp
//
//  Created by Lior Dorenboust on 06/03/2021.
//

import UIKit

class ViewController: UIViewController {

    var articels: [Article]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ArticleAPI.shared.getArticals { [weak self] (results) in
            switch results {
            case .success(let articels):
                self?.articels = articels
                print("articels: \(self?.articels)")
                
            case .failure(let error):
                print("error: \(error)")
                
            }
        }
        
        
        
    }
}
