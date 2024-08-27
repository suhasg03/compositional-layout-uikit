//
//  AppCollectionViewCell.swift
//  Compositional Layout
//
//  Created by Suhas G on 25/05/24.
//

import UIKit

class AppCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var applicationCell: UIView!
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var topSectionImageView: UIImageView!
    
    var sectionIndex: Int?
    
    var cellData: HomeScreenModel? {
        didSet {
            self.gameImageView.image = UIImage(named: cellData!.image)
            self.gameNameLabel.text = cellData!.name
            if self.sectionIndex == 0 {
                self.topSectionImageView.isHidden = false
                self.topSectionImageView.image = UIImage(named: cellData!.image)
            } else {
                self.topSectionImageView.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.applicationCell.layer.cornerRadius = 5.0
    }

}
