//
//  ViewController.swift
//  StoryboardPlanetPediaApp
//
//  Created by racoon on 6/18/24.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var planetCollectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return solarSystemPlanets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PlanetCollectionViewCell.self), for: indexPath) as! PlanetCollectionViewCell
        
        let targetPlanet = solarSystemPlanets[indexPath.item]
        let lowPlanetName = targetPlanet.englishName.lowercased()
        
        cell.planetImageView.image = UIImage(named: "\(lowPlanetName)-icon")
        cell.planetNameLabel.text = targetPlanet.englishName
        
        return cell
        
    }
    
    
}
