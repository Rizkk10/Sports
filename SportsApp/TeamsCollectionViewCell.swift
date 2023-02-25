//
//  TeamsCollectionViewCell.swift
//  CollectionViewDemo
//
//  Created by Rezk on 16/02/2023.
//

import UIKit

class TeamsCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var teamImage: UIImageView!
    
    func setupCellforteams(photo:UIImage){
        teamImage.image = photo
    }
}
