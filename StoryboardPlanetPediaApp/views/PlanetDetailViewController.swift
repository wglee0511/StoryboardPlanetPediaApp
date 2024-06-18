//
//  PlanetDetailViewController.swift
//  StoryboardPlanetPediaApp
//
//  Created by racoon on 6/18/24.
//

import UIKit

class PlanetDetailViewController: UIViewController {
    
    
    @IBOutlet weak var dimmingView: UIView!
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
    
    func setLayout () {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            switch sectionIndex {
            case 1:
                var size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(130))
                var item = NSCollectionLayoutItem(layoutSize: size)
                
                size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(130))
                
                var group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
                group.interItemSpacing  = NSCollectionLayoutSpacing.flexible(20)
                
                size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(130))
            
                item = NSCollectionLayoutItem(layoutSize: size)
                group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [group, item])
                group.interItemSpacing  = NSCollectionLayoutSpacing.fixed(20)
                
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
                section.interGroupSpacing = 10
                
                return section
            case 2:
                var size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
                
                let item = NSCollectionLayoutItem(layoutSize: size)
                
                size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.6), heightDimension: .estimated(200))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
                section.interGroupSpacing = 20
                section.orthogonalScrollingBehavior = .continuous
                
                return section
            default:
                let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
                
                let item = NSCollectionLayoutItem(layoutSize: size)
                let group = NSCollectionLayoutGroup.vertical(layoutSize: size, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
                section.interGroupSpacing = 20
                
                return section
            }
        }
        
        planetDetailCollectionView.collectionViewLayout = layout
    
    }
    
    func adjustContentInset () {
        let indexPath = IndexPath(item: 0, section: 0)
        
        if let cell = planetDetailCollectionView.cellForItem(at: indexPath) {
            let topInset = planetDetailCollectionView.frame.height - cell.frame.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 20
            
            planetDetailCollectionView.contentInset = UIEdgeInsets(top: topInset, left: 0, bottom: 0, right: 0)
            planetDetailCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: .bottom)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        adjustContentInset()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        planetImageView.image = UIImage(named: planet.englishName.lowercased())
        setLayout()
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
            
            switch indexPath.item {
            case 0:
                cell.planetIcon.image = UIImage(systemName: "ruler")
                cell.titleLabel.text = "크기"
                cell.valueLabel.text = planet.sizeString
                cell.unitLabel.text = "Km"
            case 1:
                cell.planetIcon.image = UIImage(systemName: "arrow.circlepath")
                cell.titleLabel.text = "공전 주기"
                cell.valueLabel.text = planet.orbitalPeriodString
                cell.unitLabel.text = planet.isYear ? "년" : "일"
                
            case 2:
                cell.planetIcon.image = UIImage(systemName: "airplane")
                cell.titleLabel.text = "지구와의 거리"
                cell.valueLabel.text = planet.distanceString
                cell.unitLabel.text = "Km"
            default:
                break
            }
            
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

extension PlanetDetailViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentSize = scrollView.contentSize.height
        let offsetY = abs(scrollView.contentOffset.y)
        let y = abs(contentSize - (offsetY + view.safeAreaInsets.top + view.safeAreaInsets.bottom + 20))
        let alpha = y / contentSize
        dimmingView.alpha = alpha < 0.4 ? alpha : 0. 4
    }
}
