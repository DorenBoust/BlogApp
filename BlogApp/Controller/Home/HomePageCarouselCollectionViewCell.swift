//
//  HomePageCarouselCollectionViewCell.swift
//  BlogApp
//
//  Created by Lior Dorenboust on 12/03/2021.
//

import UIKit

class HomePageCarouselCollectionViewCell: UICollectionViewCell {
    //MARK: - outlets
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    //MARK: - properties
    var category: Category! {
        didSet {
            self.setCell()
        }
    }
    
    //MARK: - auction
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
    }
    //MARK: - func
    private func setCell(){
        if let category = category{
            categoryNameLabel.text = category.name
            self.layer.cornerRadius = 10.0
            self.layer.masksToBounds = true
            
        }
    }
}

//MARK: - extension
