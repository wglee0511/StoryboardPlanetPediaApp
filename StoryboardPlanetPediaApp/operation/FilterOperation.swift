//
//  FilterOperation.swift
//  StoryboardPlanetPediaApp
//
//  Created by racoon on 7/5/24.
//

import Foundation
import UIKit

class FilterOperation: Operation {
    let target: PhotoData
    let context = CIContext(options: nil)
    
    init(target: PhotoData) {
        self.target = target
        
        super.init()
    }
    
    override func main() {
        print("Filter Start", target.url)
        
        defer {
            if self.isCancelled {
                print("Filter Cancel")
            } else {
                print("Filter Done")
            }
        }
        
        guard !Thread.isMainThread else {
            fatalError()
        }
        
        guard !self.isCancelled else {
            return
        }
        
        guard let source = target.image?.cgImage else {
            fatalError()
        }
        
        let ciImage = CIImage(cgImage: source)
        
        guard !self.isCancelled else {
            return
        }
        
        let filter = CIFilter(name: "CIPhotoEffectNoir")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        
        guard !self.isCancelled else {
            return
        }
        
        guard let resultCiImage = filter?.value(forKey: kCIInputImageKey) as? CIImage else {
            fatalError()
        }
        
        guard !self.isCancelled else {
            return
        }
        
        guard let cgImage = context.createCGImage(resultCiImage, from: resultCiImage.extent) else {
            fatalError()
        }
        
        target.image = UIImage(cgImage: cgImage)
    }
    
    override func cancel() {
        super.cancel()
    }
}
