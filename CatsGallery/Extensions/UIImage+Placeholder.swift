//
//  UIImage+Placeholder.swift
//  CatsGallery
//
//  Created by Źmicier Fiedčanka on 24.11.21.
//

import UIKit

extension UIImage {
    
    static let placeholder = UIImage(named: "placeholder-\(Int.random(in: 1...4))")
    
    var isEqualToPlaceholder: Bool {
        let placeholders = (1...4).compactMap { UIImage(named: "placeholder-\($0)") }
        return placeholders.contains(self)
    }
}
