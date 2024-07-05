//
//  ReloadOperation.swift
//  StoryboardPlanetPediaApp
//
//  Created by racoon on 7/5/24.
//

import Foundation
import UIKit

class ReloadOperation: Operation {
    weak var collectionView: UICollectionView!
    var indexPath: IndexPath?
    
    
    init(collectionView: UICollectionView, indexPath: IndexPath?) {
        self.collectionView = collectionView
        self.indexPath = indexPath
        
        super.init()
    }
    
    
    override func main() {
        print("Reload Start", self.indexPath ?? 0)
        
        defer {
            if self.isCancelled {
                print("Reload Cancel")
            } else {
                print("Reload Done")
            }
        }
        
        guard Thread.isMainThread else {
            fatalError()
        }
        
        guard !self.isCancelled else {
            return
        }
        
        
        if let indexPath {
            if collectionView.indexPathsForVisibleItems.contains(indexPath) {
                collectionView.reloadItems(at: [indexPath])
            }
        } else {
            collectionView.reloadData()
        }
    }
    
    override func cancel() {
        super.cancel()
    }
}
