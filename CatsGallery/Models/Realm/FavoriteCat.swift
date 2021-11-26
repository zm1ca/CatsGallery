//
//  CatImage.swift
//  CatsGallery
//
//  Created by Źmicier Fiedčanka on 24.11.21.
//

import Foundation
import RealmSwift

class FavoriteCat: Object {
    
    @Persisted var imageData: Data
    
    convenience init(imageData: Data) {
        self.init()
        self.imageData = imageData
    }
}
