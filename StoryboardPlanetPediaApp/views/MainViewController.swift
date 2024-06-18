//
//  ViewController.swift
//  StoryboardPlanetPediaApp
//
//  Created by racoon on 6/18/24.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var planetCollectionView: UICollectionView!
    
    @IBSegueAction func planetDetailSegue(_ coder: NSCoder, sender: Any?) -> PlanetDetailViewController? {
        
        guard let cell = sender as? PlanetCollectionViewCell, let indexPath = planetCollectionView.indexPath(for: cell) else {
            return nil
        }
        
        let targetPlanet = solarSystemPlanets[indexPath.item]
        
        return PlanetDetailViewController(planet: targetPlanet, coder: coder)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let cell = sender as? UICollectionViewCell, let indexPath = planetCollectionView.indexPath(for: cell) {
//            let targetPlanet = solarSystemPlanets[indexPath.row]
//            
//            if let targetViewController = segue.destination as? PlanetDetailViewController {
//                targetViewController.planet = targetPlanet
//            }
//        }
//    }
    
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

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }
        let width =  Int((self.planetCollectionView.bounds.width - (layout.minimumInteritemSpacing + layout.sectionInset.left + layout.sectionInset.right)) / 2)
        return CGSize(width: width, height: width )
    }
}
