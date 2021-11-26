//
//  FavoritesVC+InfinitePaging.swift
//  CatsGallery
//
//  Created by Źmicier Fiedčanka on 23.11.21.
//

import UIKit

extension FavoritesVC {
    
    //MARK: - Managing infinite loop
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        guard !preparationsForPresentingInfiteColectionViewWereDone, collectionView.numberOfItems(inSection: 0) > 1 else { return }
        preparationsForPresentingInfiteColectionViewWereDone = true
        self.collectionView.scrollToItem(at: IndexPath(item: favoriteCatImages.pseudoInfinite.count - 2, section: 0), at: .left, animated: false)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        scrollView.isUserInteractionEnabled = false
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.isUserInteractionEnabled = true
        guard collectionView.numberOfItems(inSection: 0) > 1 else { return }
        updateScrollPositionToNotHitBorders(for: scrollView)
    }
    
    func updateScrollPositionToNotHitBorders(for scrollView: UIScrollView) {
        let pageFloat = (scrollView.contentOffset.x / scrollView.frame.size.width)
        let pageInt = Int(round(pageFloat))

        switch pageInt {
        case 0:
            collectionView.scrollToItem(at: [0, favoriteCatImages.pseudoInfinite.count - 2], at: .left, animated: false)
        case favoriteCatImages.pseudoInfinite.count - 1:
            collectionView.scrollToItem(at: [0, 1], at: .left, animated: false)
        default:
            break
        }
    }
}


