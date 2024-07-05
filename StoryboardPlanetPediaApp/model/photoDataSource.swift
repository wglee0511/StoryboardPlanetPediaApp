//
//  photoDataSource.swift
//  StoryboardPlanetPediaApp
//
//  Created by racoon on 7/5/24.
//

import Foundation

struct PhotoDataSource {
    var list:[PhotoData]
    
    init() {
        var list = [PhotoData]()
        
        for number in 1 ... 20 {
            let url = "https://kxcodingblob.blob.core.windows.net/mastering-ios/\(number).jpg"
            
            let data = PhotoData(url: url)
            
            list.append(data)
        }
        
        self.list = list
    }
}
