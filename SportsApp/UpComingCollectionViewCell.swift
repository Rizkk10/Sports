//
//  UpComingCollectionViewCell.swift
//  CollectionViewDemo
//
//  Created by Rezk on 16/02/2023.
//

import UIKit
import Kingfisher

class UpComingCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var upComingLabel: UILabel!
    
    @IBOutlet weak var homeTeamImageView: UIImageView!
    
    @IBOutlet weak var homeTeamLabel: UILabel!
    
    @IBOutlet weak var eventDateLabel: UILabel!
    
    @IBOutlet weak var awayTeamImageView: UIImageView!
    
    @IBOutlet weak var awayTeamLabel: UILabel!
    
    func configureCell(homeTitle : String , awayTitle : String , eventDate : String , homeLogo : String , awaylogo : String){
        
        
        self.layer.cornerRadius = 25
        
        homeTeamLabel.text = homeTitle
        awayTeamLabel.text = awayTitle
        eventDateLabel.text = eventDate
        
        
        let url = URL(string: homeLogo)
        
        homeTeamImageView.kf.indicatorType = .activity
        
        homeTeamImageView.kf.setImage(
            with: url,
            placeholder: "football" as? Placeholder ,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ],
            progressBlock: nil
        )
        
        let url2 = URL(string: awaylogo)
        
        awayTeamImageView.kf.indicatorType = .activity
        
        awayTeamImageView.kf.setImage(
            with: url2,
            placeholder: "football" as? Placeholder  ,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ],
            progressBlock: nil
        )
    }
    
    
    
    
}
