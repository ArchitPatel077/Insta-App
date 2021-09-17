//
//  ProfileCell.swift
//  ProfileCell
//
//  Created by Archit Patel on 2021-09-12.
//

import UIKit

class ProfileCell : UICollectionViewCell {
    
    //MARK: - Properties
    
    var viewModel : PostViewModel? {
        didSet{
            configureUI()
        }
    }
    
    private let postImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "venom-7")!
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        return iv
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        addSubview(postImageView)
        postImageView.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        guard let viewModel = viewModel else {return}
        
        postImageView.sd_setImage(with: viewModel.imageUrl)
    }
}
