//
//  PlanetDetailViewController.swift
//  StoryboardPlanetPediaApp
//
//  Created by racoon on 6/18/24.
//

import UIKit

class PlanetDetailViewController: UIViewController {
    
    var planet: Planet?

    @IBOutlet weak var planetImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let planet {
            planetImageView.image = UIImage(named: planet.englishName.lowercased())

        }
    }
}
