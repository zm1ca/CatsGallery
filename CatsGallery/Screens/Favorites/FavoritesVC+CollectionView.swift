//
//  FavoritesVC+CollectionView.swift
//  CatsGallery
//
//  Created by Źmicier Fiedčanka on 22.11.21.
//

import UIKit

extension FavoritesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - Configuration and protocol conformance
    func configureFavoritesCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createSingleColumnFlowLayout(in: view))
        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.reuseID)
        collectionView.delegate   = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        
        view.addSubview(collectionView)
        collectionView.pinToSafeAreaEdges(of: view)
        collectionView.backgroundColor = view.backgroundColor
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favoriteCatImages.pseudoInfinite.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.reuseID, for: indexPath) as? FavoriteCell else { return UICollectionViewCell() }
        cell.imageView.image = favoriteCatImages.pseudoInfinite[indexPath.row]
        return cell
    }
}
