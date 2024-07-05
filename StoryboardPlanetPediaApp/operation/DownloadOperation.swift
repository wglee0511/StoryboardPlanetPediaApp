//
//  DownloadOperation.swift
//  StoryboardPlanetPediaApp
//
//  Created by racoon on 7/5/24.
//

import Foundation
import UIKit

class DownloadOperation: Operation {
    let target: PhotoData
    
    init(target: PhotoData) {
        self.target = target
        super.init()
    }
    
    override func main() {
        print(target.url, "Download Start")
        
        defer {
            if self.isCancelled {
                print(target.url, "Download Cancel")
            } else {
                print(target.url, "Download Done")
            }
        }
        
        guard !Thread.isMainThread else {
            fatalError()
        }
        
        guard !self.isCancelled else {
            return
        }
        
        do {
            let data = try Data(contentsOf: target.url)
            
            guard !self.isCancelled else {
                return
            }
            
            if let image = UIImage(data: data) {
                let size = image.size.applying(CGAffineTransform(scaleX: 0.3, y: 0.3))
                
                UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
                
                let frame = CGRect(origin: .zero, size: size)
                image.draw(in: frame)
                
                let resultImage = UIGraphicsGetImageFromCurrentImageContext()
                
                UIGraphicsEndImageContext()
                
                guard !self.isCancelled else {
                    return
                }
                
                target.image = resultImage
            }
            
        } catch {
            print("error", error.localizedDescription)
        }
    }
    
    override func cancel() {
        super.cancel()
    }
}
