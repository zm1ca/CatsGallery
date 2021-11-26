//
//  EmptyStateView.swift
//  CatsGallery
//
//  Created by Źmicier Fiedčanka on 25.11.21.
//

import UIKit

class EmptyStateView: UIView {
    
    let emptystateImage: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "emptystate")
        return img
    }()
    
    let emptystateLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text          = "No favorite cats yet :("
        lbl.textAlignment = .center
        lbl.textColor     = .darkSlateGray
        lbl.font          = UIFont.systemFont(ofSize: 20, weight: .bold)
        return lbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubviews(emptystateImage, emptystateLabel)
        NSLayoutConstraint.activate([
            emptystateImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptystateImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            emptystateImage.heightAnchor.constraint(equalToConstant: 174),
            emptystateImage.widthAnchor.constraint(equalToConstant: 340),
            
            emptystateLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            emptystateLabel.topAnchor.constraint(equalTo: emptystateImage.bottomAnchor),
            emptystateLabel.heightAnchor.constraint(equalToConstant: 80),
            emptystateLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 16),
            emptystateLabel.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: -16)
        ])
    }

}
