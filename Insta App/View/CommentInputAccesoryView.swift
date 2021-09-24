//
//  CommentInputAccesoryView.swift
//  CommentInputAccesoryView
//
//  Created by Archit Patel on 2021-09-24.
//

import UIKit

protocol CommentInputAccessoryViewDelegate : AnyObject {
    func inputView(_ inputView : CommentInputAccessoryView, wantsToUploadComment comment: String)
}


class CommentInputAccessoryView : UIView {
     
    //MARK: - Properties
    
    weak var delegate : CommentInputAccessoryViewDelegate?
    
    private let commentTextView : InputTextView = {
       let tv = InputTextView()
        tv.placeHolderText = "Enter comment..."
        tv.font = UIFont.systemFont(ofSize: 15)
        tv.isScrollEnabled = false
        tv.placeholderShouldCenter = true 
        return tv
    }()
    
    private let postButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handlePostTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        autoresizingMask = .flexibleHeight
        
        addSubview(postButton)
        postButton.anchor(top: topAnchor, right: rightAnchor, paddingRight: 8)
        postButton.setDimensions(height: 50, width: 50)
        
        addSubview(commentTextView)
        commentTextView.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: postButton.leftAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
        
        let divider = UIView()
        divider.backgroundColor = .lightGray
        addSubview(divider)
        divider.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    //MARK: - Actions
    
    @objc func handlePostTapped() {
        
        delegate?.inputView(self, wantsToUploadComment: commentTextView.text)
    }
    
    //MARK: - Helpers
    
    func clearCommentTextView() {
        commentTextView.text = nil
        commentTextView.placeholderLabel.isHidden = false
    }
}
