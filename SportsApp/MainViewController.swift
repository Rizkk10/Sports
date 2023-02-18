//
//  MainViewController.swift
//  CollectionViewDemo
//
//  Created by Rezk on 16/02/2023.
//

import UIKit
import Alamofire

class MainViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var teamsCell: UICollectionView!
    
    @IBOutlet weak var upComingCell: UICollectionView!
    
    @IBOutlet weak var latestResultsCell: UICollectionView!
    
    
    var homeTeam: [String] = []
    var awayTeam: [String] = []
    var awayTeamLogo: [String] = []
    var homeTeamLogo: [String] = []
    var eventDate: [String] = []
    var homeTeamKey: [Int] = []
    var index : Int = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // to know where i come from
        
        switch index {
            
        case 0 :
            fetchUpcomingResultData(apiLink : upcomingApi.Football.rawValue)
        case 1:
            fetchUpcomingResultData(apiLink : upcomingApi.Basketball.rawValue)
        case 2:
            fetchUpcomingResultCricketData(apiLink : upcomingApi.Cricket.rawValue)
        case 3:
            fetchUpcomingResultTennisData(apiLink : upcomingApi.Tennis.rawValue)
        default:
            break
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // number of items for teams
        if collectionView == teamsCell {
            
            return 40
        }
        // number of items for upComing Event
        if collectionView == upComingCell {
            
            return homeTeam.count
        }
        // number of items for latest Result
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // cofiguration cell for Teams
        if collectionView == teamsCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teams", for: indexPath) as! TeamsCollectionViewCell
            cell.backgroundColor = UIColor.red
            return cell
        }
        // cofiguration  cell for upComing Event
        if collectionView == upComingCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upComing", for: indexPath) as! UpComingCollectionViewCell
            
            switch index {
                // FootBall and Cricket
            case 0 , 2:
                cell.configureCell(homeTitle: homeTeam[indexPath.row], awayTitle: awayTeam[indexPath.row], eventDate: eventDate[indexPath.row], homeLogo: homeTeamLogo[indexPath.row] , awaylogo: awayTeamLogo[indexPath.row] )
                // Basketball and tennis
            case 1 , 3:
            
                
                cell.configureCell(homeTitle: homeTeam[indexPath.row], awayTitle: awayTeam[indexPath.row], eventDate: eventDate[indexPath.row], homeLogo: "football" , awaylogo: "football" )
                
            default:
                break
            }
            
            return cell
        }
        // cofiguration  cell for Latest Results
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestResults", for: indexPath) as! LatestResultsCollectionViewCell
        cell.backgroundColor = UIColor.purple
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: self.view.frame.width * 0.493, height: self.view.frame.width * 0.49)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
    }
    
}

