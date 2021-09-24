//
//  CommentController.swift
//  CommentController
//
//  Created by Archit Patel on 2021-09-18.
//

import UIKit

private let reuseIdentifier = "CommentCell"

class CommentController : UICollectionViewController {
    
    //MARK: - Properties
    private let post : Post
    private var comments = [Comment]()
    
    private lazy var commentInputView : CommentInputAccessoryView = {
        
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let cv = CommentInputAccessoryView(frame: frame)
        cv.delegate = self
        return cv
    }()
    
    //MARK: - Lifecycle
    
    init(post: Post){
        self.post = post
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        fetchComments()
    }
    
    override var inputAccessoryView: UIView? {
        get {
            return commentInputView
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: - Helpers
    
    func configureCollectionView() {
        
        collectionView.backgroundColor = .white
        navigationItem.title = "Comments"
        
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
    }
    
    //MARK: - API
    
    func fetchComments(){
        CommentService.fetchComment(forPost: post.postId) { comments in
            self.comments = comments
            self.collectionView.reloadData()
        }
    }
}




//MARK: - UICollectionViewDataSource

extension CommentController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell  {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CommentCell
        cell.viewModel = CommentViewModel(comment: comments[indexPath.row])
        return cell
    }
    
}

//MARK: - UICollectionViewDelegateFlowLayout

extension CommentController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewModel = CommentViewModel(comment: comments[indexPath.row])
        let height = viewModel.size(forWidth: view.frame.width).height + 32
        return CGSize(width: view.frame.width, height: height)
    }
}

//MARK: - CommentInputAccessoryViewDelegate

extension CommentController : CommentInputAccessoryViewDelegate {
    
    func inputView(_ inputView: CommentInputAccessoryView, wantsToUploadComment comment: String) {
        
        guard let tab = self.tabBarController as? MainTabController else {return}
        guard let user = tab.user else {return}
        
        self.showLoader(true)
        
        CommentService.uploadComment(comment: comment, postId: post.postId, user: user) { error in
            self.showLoader(false)
            inputView.clearCommentTextView()
            
            print("The comment is \(comment)")
        }
    }
    
}
