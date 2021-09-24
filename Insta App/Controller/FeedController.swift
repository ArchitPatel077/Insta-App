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
    
    private var posts = [Post]()
    
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
            self.collectionView.reloadData()
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
    
    func cell(_ cell: FeedCell, cellWantsToShowComments post: Post) {
        
        let controller = CommentController(post: post)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
