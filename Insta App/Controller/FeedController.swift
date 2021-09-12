//
//  FeedController.swift
//  Insta App
//
//  Created by Archit Patel on 2021-08-02.
//

import UIKit

private let reuseIdentifier = "Cell"

class FeedController : UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    
    //MARK: - Helpers
    
    func configureUI(){
        
        collectionView.backgroundColor = .white
        
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
}

//MARK: - UICollectionViewDataSource

extension FeedController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        
        return cell
        
    }
    
}

//MARK: - UICollectioViewDelegateFlowLayout

extension FeedController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width
        var height = width + 8 + 40 + 8
        height += 50
        height += 60
        
        return CGSize(width: width , height: height)
    }
}
