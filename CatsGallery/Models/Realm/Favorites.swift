//
//  Favorites.swift
//  CatsGallery
//
//  Created by Źmicier Fiedčanka on 25.11.21.
//

import Foundation
import RealmSwift

class Favorites: Object {
    
    @Persisted var cats: List<FavoriteCat>
    @Persisted(primaryKey: true) var id: Int = 0
    
    override init() {
        super.init()
        self.cats = List<FavoriteCat>()
    }
}
