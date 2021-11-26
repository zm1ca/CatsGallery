//
//  FavoriteCell.swift
//  CatsGallery
//
//  Created by Źmicier Fiedčanka on 22.11.21.
//

import UIKit

//TODO: Abstract to ImageCellProtocol with private vars and set method
class FavoriteCell: UICollectionViewCell {
    
    static let reuseID = "FavoriteCell"
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.pinToEdges(of: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
