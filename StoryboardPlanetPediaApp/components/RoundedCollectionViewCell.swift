//
//  RoundedCollectionViewCell.swift
//  StoryboardPlanetPediaApp
//
//  Created by racoon on 6/19/24.
//

import UIKit

class RoundedCollectionViewCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.subviews.first?.layer.cornerRadius = 20
        contentView.subviews.first?.clipsToBounds = true
    }
}
