//
//  MainTabController.swift
//  Insta App
//
//  Created by Archit Patel on 2021-08-02.
//

import UIKit
import Firebase

class MainTabController : UITabBarController {
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       configureViewControllers()
        checkIfUserIsLoggedIn()

        
    }
    
    //MARK: - API
    
    func checkIfUserIsLoggedIn() {
        
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: - Helpers
    
    func configureViewControllers() {
        
        tabBar.backgroundColor = .white
        
        
        let layout = UICollectionViewFlowLayout()
        let feed = templateNavigationController(unselectedImage: UIImage(named: "home_unselected")!, selectedImage: UIImage(named: "home_selected")!, rootViewController: FeedController(collectionViewLayout: layout))
        
        let search = templateNavigationController(unselectedImage: UIImage(named: "search_unselected")!, selectedImage: UIImage(named: "search_selected")!, rootViewController: SearchController())
        
        let imageSelector = templateNavigationController(unselectedImage: UIImage(named: "plus_unselected")!, selectedImage: UIImage(named: "plus_unselected")!, rootViewController: ImageSelectorController())
        
        let notification = templateNavigationController(unselectedImage: UIImage(named: "like_unselected")!, selectedImage: UIImage(named: "like_selected")!, rootViewController:NotificationController())
        
        let profileLayout = UICollectionViewFlowLayout()
        let profile = templateNavigationController(unselectedImage: UIImage(named: "profile_unselected")!, selectedImage: UIImage(named: "profile_selected")!, rootViewController: ProfileController(collectionViewLayout: profileLayout))
        
        viewControllers = [feed, search, imageSelector, notification, profile]
        
        tabBar.tintColor = .black
    }
    
    func templateNavigationController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController ) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        
        nav.tabBarItem.image = unselectedImage
        
        nav.tabBarItem.selectedImage = selectedImage
        
        nav.navigationBar.tintColor = .black
        
        return nav
        
    }
}
