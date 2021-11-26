//
//  Array+PseudoInfinite.swift
//  CatsGallery
//
//  Created by Źmicier Fiedčanka on 24.11.21.
//

import Foundation

extension Array {
    
    var pseudoInfinite: Array {
        if self.count < 2 { return self }
        return [self.last!] + self + [self.first!]
    }
}
