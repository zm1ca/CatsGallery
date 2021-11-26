//
//  CTGTabbarController.swift
//  CatsGallery
//
//  Created by Źmicier Fiedčanka on 20.11.21.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor    = .darkSlateGray
        UITabBar.appearance().barTintColor = .lightGoldenrodYellow
        self.viewControllers = [createGalleryVC(), createFavoritesVC()]
    }
    
    
    func createGalleryVC() -> GalleryVC {
        let searchVC = GalleryVC()
        searchVC.title = "Cats Gallery"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return searchVC
    }
    
    
    func createFavoritesVC() -> FavoritesVC {
        let favoritesListVC = FavoritesVC()
        favoritesListVC.title = "Favorites"
        favoritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return favoritesListVC
    }
}
