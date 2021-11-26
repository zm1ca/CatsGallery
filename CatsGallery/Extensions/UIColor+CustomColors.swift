//
//  UIColor+Ext.swift
//  CatsGallery
//
//  Created by Źmicier Fiedčanka on 20.11.21.
//

import UIKit

extension UIColor {
    
    //My Palette: https://coolors.co/b3c186-e9edc9-fefae0-354f52
    static let olivine              = UIColor(red: 179, green: 193, blue: 134)
    static let lightGoldenrodYellow = UIColor(red: 233, green: 237, blue: 201)
    static let cornsilk             = UIColor(red: 254, green: 250, blue: 224)
    static let darkSlateGray        = UIColor(red: 53,  green: 79,  blue: 82)
    static let ming                 = UIColor(red: 81,  green: 119, blue: 123)
    
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
