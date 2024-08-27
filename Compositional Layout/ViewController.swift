//
//  ViewController.swift
//  Compositional Layout
//
//  Created by Suhas G on 25/05/24.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var clCollectionView: UICollectionView!
    private var collectionViewDataSource: [[HomeScreenModel]] = []
    private let games = ["Call Of Duty", "Assassins Creed", "Prince Of Persia", "Ghost of Tsushima"]
    private let games_images = ["cod", "ac", "pop", "got"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clCollectionView.backgroundColor = .black
        
        self.generateDataSource()
        
        // Set delegate and data source
        self.clCollectionView.dataSource = self
        self.clCollectionView.setCollectionViewLayout(self.compositionalLayout(), animated: true)
        
        let nib = UINib(nibName: "AppCollectionViewCell", bundle: nil)
        self.clCollectionView.register(nib, forCellWithReuseIdentifier: "AppCollectionViewCell")
    }
    
    private func generateDataSource() {
        self.collectionViewDataSource.removeAll()
        for num in 0..<10 {
            var dataToAppend: [HomeScreenModel] = []
            dataToAppend.removeAll()
            for number in 0..<10 {
                let random_number = Int.random(in: 0..<self.games.count)
                dataToAppend.append(HomeScreenModel(id: "\(num)\(number)", name: self.games[random_number], image: self.games_images[random_number]))
            }
            self.collectionViewDataSource.append(dataToAppend)
        }
    }
    
    private func compositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8), heightDimension: .absolute(300.0))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                return section
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(120))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)
                
                let secondGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .absolute(120))
                let secondGroup = NSCollectionLayoutGroup.vertical(layoutSize: secondGroupSize, subitems: [item])
                secondGroup.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)
                
                let finalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(120))
                let finalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: finalGroupSize, subitems: [group, secondGroup])
                
                let section = NSCollectionLayoutSection(group: finalGroup)
                section.orthogonalScrollingBehavior = .groupPaging
                return section
            }
        }
        return layout
    }

    // Collection View Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionViewDataSource[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppCollectionViewCell", for: indexPath) as? AppCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = UIColor.clear
        cell.sectionIndex = indexPath.section
        cell.cellData = self.collectionViewDataSource[indexPath.section][indexPath.row]
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.collectionViewDataSource.count
    }
}

struct HomeScreenModel: Codable, Hashable {
    var id: String
    var name: String
    var image: String
}

