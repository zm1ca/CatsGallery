//
//  ViewController.swift
//  CatsGallery
//
//  Created by Źmicier Fiedčanka on 20.11.21.
//

import UIKit
import NotificationBannerSwift
import RealmSwift

class GalleryVC: CTGDataLoadingVC {
    
    var collectionView: UICollectionView!
    var catImageURLs = [URL]()
    var page = 0
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cornsilk
        configureCollectionView()
        configureActions()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        showEducationalBanner()
    }
    
    private func showEducationalBanner() {
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if !launchedBefore {
            NotificationBannerManager.shared.presentNotificationBanner(title: "Double-tap to favorite", style: .info)
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }
    }
    
    
    //MARK: - Adding to favorites
    private func configureActions() {
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(sender:)))
        doubleTap.numberOfTapsRequired = 2
        collectionView.addGestureRecognizer(doubleTap)
    }
    
    @objc private func handleDoubleTap(sender: UITapGestureRecognizer) {
        let touchPoint = sender.location(in: collectionView)
        guard let touchIndexPath = collectionView.indexPathForItem(at: touchPoint),
              let cell = collectionView.cellForItem(at: touchIndexPath) as? GalleryCell,
              let image = cell.imageView.image,
              let data = UIImage.jpegData(image)(compressionQuality: 1) else {
                  NotificationBannerManager.shared.presentNotificationBanner(title: "Saving failed", style: .danger)
                  return
        }
        
        if image.isEqualToPlaceholder {
            NotificationBannerManager.shared.presentNotificationBanner(title: "Can't save a placeholder", style: .warning)
            return
        }
        
        saveToDatabase(FavoriteCat(imageData: data))
        NotificationBannerManager.shared.presentNotificationBanner(title: "Added to favorites", style: .success)
    }
    
    private func saveToDatabase(_ cat: FavoriteCat) {
        let realm = try! Realm()
        try! realm.write({
            let favorites = realm.objects(Favorites.self).first ?? Favorites()
            favorites.cats.append(cat)
            realm.add(favorites, update: .modified)
        })
    }
    
    
    //MARK: - Getting more data
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let screenHeight    = scrollView.frame.size.height
        
        if offsetY > contentHeight - screenHeight {
            guard !isLoadingMoreData else { return }
            getNextPageOfURLs()
        }
    }

    func getNextPageOfURLs() {
        isLoadingMoreData = true
        page += 1
        
        NetworkManager.shared.loadCatImageURLs(page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let fetchedURLs):
                DispatchQueue.main.async {
                    self.catImageURLs.append(contentsOf: fetchedURLs)
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error occured:", error.rawValue)
            }
            self.isLoadingMoreData = false
        }
    }
}



