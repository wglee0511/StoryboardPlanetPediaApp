//
//  image.swift
//  StoryboardPlanetPediaApp
//
//  Created by racoon on 7/5/24.
//

import UIKit

class PhotoData {
    let url: URL
    var image: UIImage?
    
    init(url: String) {
        self.url = URL(string: url)!
    }
}
