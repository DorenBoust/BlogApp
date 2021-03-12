//
//  CategoryPageViewController.swift
//  BlogApp
//
//  Created by Lior Dorenboust on 12/03/2021.
//

import UIKit

class CategoryPageViewController: UIViewController {

    //MARK: - outlets
    
    @IBOutlet weak var testLabel: UILabel!
    //MARK: - properties
    var category: Category?
    
    //MARK: - cycleLife
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ArticleAPI.shared.getArticelsByCategory(categoryName: (self.category?.name)!) { [weak self] (results) in
            switch results {
            case .success(let articels):
                print("before category: \(self?.category)")
                print("*****")
                self?.category?.articles = articels
                print("after category: \(self?.category)")
                DispatchQueue.main.async {
                    self?.testLabel.text = self?.category?.articles?[0].title
                }
                
                print("*****")
            case .failure(let error):
                print("getArticelsByCategory error: \(error)")
            }
        }
    }
    

    //MARK: - auctions
    
    //MARK: - funcs

}

//MARK: - extension
