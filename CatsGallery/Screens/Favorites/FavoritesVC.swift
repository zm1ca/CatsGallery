//
//  FavoritesVC.swift
//  CatsGallery
//
//  Created by Źmicier Fiedčanka on 20.11.21.
//

import UIKit
import RealmSwift

class FavoritesVC: UIViewController {
    
    let emptyStateView = EmptyStateView()
    
    let unfavoriteButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(removeDispayedCatImageFromFavorites), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = .cornsilk
        btn.layer.cornerRadius = 20
        btn.layer.borderColor = UIColor.olivine.cgColor
        btn.layer.borderWidth = 2
        btn.setTitle("Unfavorite", for: .normal)
        btn.setTitleColor(.olivine, for: .normal)
        return btn
    }()
    
    var collectionView: UICollectionView!
    var favoriteCatImages: [UIImage] = [] { didSet { updateUI() } }
    
    var preparationsForPresentingInfiteColectionViewWereDone = false

    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureFavoritesCollectionView()
        
        view.backgroundColor = .cornsilk
        view.addSubviews(unfavoriteButton, emptyStateView)
        
        emptyStateView.pinToSafeAreaEdges(of: view)
        NSLayoutConstraint.activate([
            unfavoriteButton.heightAnchor.constraint(equalToConstant: 40),
            unfavoriteButton.widthAnchor.constraint(equalToConstant: 150),
            unfavoriteButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            unfavoriteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDataSourceFromDatabase()
        updateUI()
    }
    
    private func updateUI() {
        if favoriteCatImages.count == 0 {
            unfavoriteButton.isHidden = true
            emptyStateView.isHidden   = false
        } else {
            unfavoriteButton.isHidden = false
            emptyStateView.isHidden   = true
        }
    }

    
    //MARK: Working with database
    private func fetchDataSourceFromDatabase() {
        let realm = try! Realm()
        
        let favorites = realm.objects(Favorites.self).first
        
        var fetchedImages = [UIImage]()
        if let favoriteCatObjects = favorites?.cats {
            for object in favoriteCatObjects {
                if let image = UIImage(data: object.imageData) {
                    fetchedImages.append(image)
                }
            }
        }
        
        favoriteCatImages = fetchedImages
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    @objc private func removeDispayedCatImageFromFavorites() {
        let realm = try! Realm()
        try! realm.write {
            if let favorites            = realm.objects(Favorites.self).first,
               let cell                 = collectionView.visibleCells.first,
               let currectCellIndexPath = collectionView.indexPath(for: cell) {
                
                let actualRowAfterInfinitenessCompensation = favoriteCatImages.count > 1
                    ? currectCellIndexPath.row - 1
                    : currectCellIndexPath.row
                
                guard favoriteCatImages.indices.contains(actualRowAfterInfinitenessCompensation) else { return }
                favoriteCatImages.remove(at: actualRowAfterInfinitenessCompensation)
                favorites.cats.remove(at: actualRowAfterInfinitenessCompensation)
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.updateScrollPositionToNotHitBorders(for: self.collectionView)
                }
                
                NotificationBannerManager.shared.presentNotificationBanner(title: "Removed from favorites", style: .danger)
            }
        }
    }
}
