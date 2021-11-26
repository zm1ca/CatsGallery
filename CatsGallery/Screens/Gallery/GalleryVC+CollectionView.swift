//
//  GalleryVC+CollectionView.swift
//  CatsGallery
//
//  Created by Źmicier Fiedčanka on 22.11.21.
//

import UIKit

extension GalleryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createTwoColumnNoPaddingFlowLayout(in: view))
        collectionView.register(GalleryCell.self, forCellWithReuseIdentifier: GalleryCell.reuseID)
        collectionView.delegate   = self
        collectionView.dataSource = self
        getNextPageOfURLs()
        
        view.addSubview(collectionView)
        collectionView.pinToSafeAreaEdges(of: view)
        collectionView.backgroundColor = .darkSlateGray
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        catImageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryCell.reuseID, for: indexPath) as? GalleryCell else { return UICollectionViewCell() }
        cell.delegate = self
        loadImageAndUpdateCellOnMainThread(for: indexPath, in: collectionView)
        return cell
    }
    
    
    private func loadImageAndUpdateCellOnMainThread(for indexPath: IndexPath, in collectionView: UICollectionView) {
        NetworkManager.shared.loadImage(from: catImageURLs[indexPath.row]) { image in
            DispatchQueue.main.async {
                if let cellToUpdate = collectionView.cellForItem(at: indexPath) as? GalleryCell {
                    cellToUpdate.imageView.image = image
                    cellToUpdate.downloadButton.isHidden = false
                }
            }
        }
    }
}
