//
//  GalleryCell.swift
//  CatsGallery
//
//  Created by Źmicier Fiedčanka on 20.11.21.
//

import UIKit

protocol PresentingDocumentPickerVCDelegate {
    func presentDocumentPickerVC(forExporting urls: [URL])
}

class GalleryCell: UICollectionViewCell {
    
    var delegate: PresentingDocumentPickerVCDelegate!
    
    static let reuseID = "GalleryCell"
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode   = .scaleAspectFill
        iv.image         =  UIImage.placeholder
        return iv
    }()
    
    let downloadButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "download"), for: .normal)
        btn.layer.cornerRadius  = 22
        btn.layer.masksToBounds = false
        btn.layer.shadowColor   = UIColor.lightGoldenrodYellow.cgColor
        btn.layer.shadowOpacity = 0.8
        btn.layer.shadowRadius  = 3
        btn.layer.shadowOffset  = CGSize.zero
        btn.isHidden            = true
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cornsilk
        addSubviews(imageView, downloadButton)
        imageView.pinToEdges(of: self)
        NSLayoutConstraint.activate([
            downloadButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            downloadButton.heightAnchor.constraint(equalToConstant: 44),
            downloadButton.widthAnchor.constraint(equalTo: downloadButton.heightAnchor)
        ])
        
        downloadButton.addTarget(self, action: #selector(shareImage), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        DispatchQueue.main.async {
            self.downloadButton.isHidden = true
            self.imageView.image = UIImage.placeholder
        }
    }
    
    @objc private func shareImage() {
        if let pngData = imageView.image?.pngData(),
           let documentsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = documentsDir.appendingPathComponent("CatsGalleryPic-\(arc4random_uniform(1000000)).png")
            do {
                try pngData.write(to: fileURL)
            } catch let error {
                NotificationBannerManager.shared.presentNotificationBanner(title: "Error occured while saving", style: .danger)
                print("Error occured while writing to file:", error.localizedDescription )
            }
            delegate.presentDocumentPickerVC(forExporting: [fileURL])
        } else {
            NotificationBannerManager.shared.presentNotificationBanner(title: "Image isn't valid", style: .danger)
        }
    }
}
