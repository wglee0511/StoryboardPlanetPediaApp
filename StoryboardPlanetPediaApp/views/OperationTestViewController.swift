//
//  OperationTestViewController.swift
//  StoryboardPlanetPediaApp
//
//  Created by racoon on 7/5/24.
//

import UIKit

class OperationTestViewController: UIViewController {
    
    @IBOutlet weak var operationTestCollectionView: UICollectionView!
    
    let backgroundQueue = OperationQueue()
    let mainQueue = OperationQueue.main
    
    let dataSource = PhotoDataSource()
    
    @IBAction func onPressCancelOperation(_ sender: Any) {
        backgroundQueue.cancelAllOperations()
        mainQueue.cancelAllOperations()
    }
    
    @IBAction func onPressStartOperation(_ sender: Any) {
        var uiOperations = [Operation]()
        var backgroundOperations = [Operation]()
        
        let reloadOperation = ReloadOperation(collectionView: operationTestCollectionView)
        
        uiOperations.append(reloadOperation)
        
        for index in 0 ... (dataSource.list.count - 1) {
            let data = dataSource.list[index]
            let downloadOperation = DownloadOperation(target: data)
            
            reloadOperation.addDependency(downloadOperation)
            backgroundOperations.append(downloadOperation)
            
            let filterOperation = FilterOperation(target: data)
            filterOperation.addDependency(reloadOperation)
            backgroundOperations.append(filterOperation)
            
            let reloadCellOperation = ReloadOperation(collectionView: operationTestCollectionView, indexPath: IndexPath(item: index, section: 0))
            reloadCellOperation.addDependency(filterOperation)
            uiOperations.append(reloadCellOperation)
        }
        
        backgroundQueue.addOperations(backgroundOperations, waitUntilFinished: false)
        mainQueue.addOperations(uiOperations, waitUntilFinished: false)
        
    }
    
    func setLayout () {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            // 4:3 비율의 아이템 크기 설정
            // 한줄에 몇개씩(가로 길이 0.3 배)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .estimated(100))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            // 그룹 크기 설정
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .flexible(10)
            
            // 섹션 설정
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            return section
        }
        operationTestCollectionView.collectionViewLayout = layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}


extension OperationTestViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: OperationTestCollectionViewCell.self), for: indexPath) as! OperationTestCollectionViewCell
        
        let row = indexPath.row
        let photoData = dataSource.list[row]
        cell.imageVIew.image = photoData.image
        
        return cell
    }
    
    
}
