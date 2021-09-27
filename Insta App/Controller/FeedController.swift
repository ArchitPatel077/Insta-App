//
//  FeedController.swift
//  Insta App
//
//  Created by Archit Patel on 2021-08-02.
//

import UIKit
import Firebase



private let reuseIdentifier = "Cell"

class FeedController : UICollectionViewController {
    
    //MARK: - Properties
    
    private var posts = [Post]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var post : Post?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchPosts()
    }
    
    //MARK: - Actions
    
    @objc func handleLogout() {
        do{
            try Auth.auth().signOut()
            
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            controller.delegate = self.tabBarController as? MainTabController
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
            
        } catch {
            print("DEBUG: Failed to sigh out")
        }
    }
    
    @objc func handleRefresh() {
        
        posts.removeAll()
        fetchPosts()
    }
    
    //MARK: - API
    
    func fetchPosts() {
        
        guard  post == nil else {return}
        PostService.fetchPost { posts in
            
            self.posts = posts
            self.collectionView.refreshControl?.endRefreshing()
            self.checkIfUserLikedPosts()
           
        }
    }
    
    func checkIfUserLikedPosts() {
        self.posts.forEach { post in
            PostService.checkIfUserLikedPost(post: post) { didLike in
                if let index = self.posts.firstIndex(where: {$0.postId == post.postId}) {
                    self.posts[index].didLike = didLike
                }
            }
        }
    }
    
    //MARK: - Helpers
    
    func configureUI(){
        
        collectionView.backgroundColor = .white
        
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        if post == nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        }
        
        
        
        navigationItem.title = "Feed"
        
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refresher
    }
}


//MARK: - UICollectionViewDataSource

extension FeedController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post == nil ? posts.count : 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FeedCell
        cell.delegate = self
        if let post = post {
            cell.viewModel = PostViewModel(post: post)
        } else {
            cell.viewModel = PostViewModel(post: posts[indexPath.row])

        }
    
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
//MARK: - FeedCellDelegate

extension FeedController : FeedCellDelegate {
    
    func cell(_ cell: FeedCell, didLike post: Post) {
        
        cell.viewModel?.post.didLike.toggle() 
        
        if post.didLike {
            
            PostService.unlikePost(post:  post) { _ in
                cell.likeButton.setImage(UIImage(named: "like_unselected"), for: .normal)
                cell.likeButton.tintColor = .black
                cell.viewModel?.post.likes = post.likes - 1
            }
            
        } else {
            
            PostService.likePost(post: post) { _ in
//                if let error = error {
//                    print("DEBUG: Failed to like post... \(error)")
//                }
                
                cell.likeButton.setImage(UIImage(named: "like_selected"), for: .normal)
                cell.likeButton.tintColor = UIColor.red
                cell.viewModel?.post.likes = post.likes + 1
            }
        }
        
    }
    
    func cell(_ cell: FeedCell, cellWantsToShowComments post: Post) {
        
        let controller = CommentController(post: post)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
