//
//  ViewController.swift
//  BlogApp
//
//  Created by Lior Dorenboust on 06/03/2021.
//

import UIKit

class HomeViewController: UIViewController {
    //MARK: - outlets
    @IBOutlet weak var categoriesCarouselCollectionView: UICollectionView!
    
    //MARK: - properties
    let cellScale: CGFloat = 0.6 // for 'responsiveLayout' func
    var homeUpdate: HomeUpdate?
    
    //MARK: - cycleLife
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriesCarouselCollectionView.delegate = self
        categoriesCarouselCollectionView.dataSource = self
        
        HomeModel.shared.updateArticels { [weak self] (homeUpdateResults) in
            switch homeUpdateResults {
            
            case .success(let homeUpdate):
                self?.homeUpdate = homeUpdate
                DispatchQueue.main.async {
                    self?.categoriesCarouselCollectionView.reloadData()
                }
                
            case .failure(let error):
                print("homeUpdate error: \(error)")
            }
        }
        
        
    }
    
    //MARK: - auctions
    
   
    //MARK: - funcs
}

//MARK: - extensions
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    //MARK: - functions
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return self.homeUpdate?.categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCarousel", for: indexPath) as! HomePageCarouselCollectionViewCell
        
        let category = self.homeUpdate?.categories![indexPath.item]
        cell.category = category
        
        return cell
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "CategoryPage", bundle: nil)
        let categoryPageViewController = storyboard.instantiateViewController(withIdentifier: "CategoryPageViewController") as! CategoryPageViewController
        categoryPageViewController.category = self.homeUpdate?.categories![indexPath.item]
        self.navigationController?.pushViewController(categoryPageViewController, animated: true)

    }
    
    // frize card when scralling
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.categoriesCarouselCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        
        targetContentOffset.pointee = offset
        
    }
    
    
    
    private func responsiveLayout(){ // not useing that
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScale)
        let cellHeight = floor(screenSize.height * cellScale)
        let indetX = (view.bounds.width - cellWidth) / 2.0
        let indetY = (view.bounds.height - cellHeight) / 2.0

        let layout = self.categoriesCarouselCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        self.categoriesCarouselCollectionView.contentInset = UIEdgeInsets(top: indetY, left: indetX, bottom: indetY, right: indetX)

    }
    
    
}
