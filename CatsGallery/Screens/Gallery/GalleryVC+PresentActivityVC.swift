//
//  GalleryVC+PresentActivityVC.swift
//  CatsGallery
//
//  Created by Źmicier Fiedčanka on 25.11.21.
//

import UIKit

extension GalleryVC: PresentingDocumentPickerVCDelegate {
    
    func presentDocumentPickerVC(forExporting urls: [URL]) {
        let vc = UIDocumentPickerViewController(forExporting: urls)
        present(vc, animated: true)
    }

}

