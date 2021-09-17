//
//  InputTextView.swift
//  InputTextView
//
//  Created by Archit Patel on 2021-09-16.
//

import UIKit

class InputTextView : UITextView {
    
    //MARK: - Properties
    
    var placeHolderText : String? {
        
        didSet{
            placeholderLabel.text = placeHolderText
        }
    }
    
    private let placeholderLabel : UILabel = {
       let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    
   
    //MARK: - Lifecycle
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 6, paddingLeft: 8)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    
    @objc func handleTextDidChange(){
        
        placeholderLabel.isHidden = !text.isEmpty
    }
}
