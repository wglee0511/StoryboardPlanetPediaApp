//
//  CustomOperation.swift
//  StoryboardPlanetPediaApp
//
//  Created by racoon on 7/3/24.
//

import Foundation


class CustomOperation: Operation {
    let type: String
    
    init(type: String) {
        self.type = type
    }
    
    override func main() {
        for _ in 1 ..< 100 {
            guard !isCancelled else { return }
            
            print(type, separator: " ", terminator: " ")
            
            Thread.sleep(forTimeInterval: 0.9)
        }
    }
}
