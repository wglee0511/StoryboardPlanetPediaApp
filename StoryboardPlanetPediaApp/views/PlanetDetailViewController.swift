//
//  PlanetDetailViewController.swift
//  StoryboardPlanetPediaApp
//
//  Created by racoon on 6/18/24.
//

import UIKit

class PlanetDetailViewController: UIViewController {
    
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
