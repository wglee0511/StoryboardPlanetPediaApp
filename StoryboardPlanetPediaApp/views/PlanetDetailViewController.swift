//
//  PlanetDetailViewController.swift
//  StoryboardPlanetPediaApp
//
//  Created by racoon on 6/18/24.
//

import UIKit

class PlanetDetailViewController: UIViewController {
    
    @IBOutlet weak var planetDetailCollectionView: UICollectionView!
    private let planet: Planet
    
    init?(planet: Planet, coder: NSCoder) {
        self.planet = planet
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("에러")
    }

    @IBOutlet weak var planetImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            planetImageView.image = UIImage(named: planet.englishName.lowercased())

    }
}

extension PlanetDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        default:
            return planet.satellites.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = indexPath.section
        
        switch section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PlanetDetailCollectionViewCell.self), for: indexPath) as! PlanetDetailCollectionViewCell
            
            cell.planetKoreanName.text = planet.koreanName
            cell.planetEnglishName.text = planet.englishName
            cell.planetDescription.text = planet.description
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PlanetInfoCollectionViewCell.self), for: indexPath) as! PlanetInfoCollectionViewCell
            
            cell.titleLabel.text = "거리"
            cell.valueLabel.text = "1만"
            cell.unitLabel.text = "Km"
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SetelliteCollectionViewCell.self), for: indexPath) as! SetelliteCollectionViewCell
            
            let target = planet.satellites[indexPath.item]
            cell.setelliteName.text = target.koreanName
            cell.setelliteSummary.text = target.summary
                return cell
        }
    }
    
    
}
