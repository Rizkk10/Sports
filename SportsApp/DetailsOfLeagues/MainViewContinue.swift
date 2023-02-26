//
//  MainViewContinue.swift
//  CollectionViewDemo
//
//  Created by Rezk on 17/02/2023.
//

import Foundation
import Alamofire
import UIKit


extension MainViewController {
    
    func fetchData(apiLink : String, compilation: @escaping (DetailsResponse?) -> Void)
    {
        AF.request(apiLink).response
        { response in
            if let data = response.data {
                do{
                    let result = try JSONDecoder().decode(DetailsResponse.self, from: data)
                    print(result.success!)
                    compilation(result)
                    DispatchQueue.main.async {
                        self.dataDetails = result
                        self.upComingCell.reloadData()
                        self.latestResultsCell.reloadData()
                        self.teamsCell.reloadData()
                    }
                }
                catch{
                    compilation(nil)
                }
            } else {
                compilation(nil)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if(collectionView == teamsCell){
            let storyBoard = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
            
            let team = dataDetails?.result[indexPath.row]
            let homeTeamImg = team?.home_team_logo ?? ""
            storyBoard.teeamImg = String(homeTeamImg)
            if index == 3 {
                let homeTeamKey = team?.first_player_key ?? 0
                storyBoard.teamKey = String(homeTeamKey)
            }
            else {
                let homeTeamKey = team?.home_team_key ?? 0
                storyBoard.teamKey = String(homeTeamKey)
            }
            
            
            
            switch index {
            case 0 :
                storyBoard.sportType = "football"
                storyBoard.teamIndex = 0
                
            case 1 :
                storyBoard.sportType = "basketball"
                storyBoard.teamIndex = 1
                
            case 2 :
                storyBoard.sportType = "cricket"
                storyBoard.teamIndex = 2
                
            case 3 :
                storyBoard.sportType = "tennis"
                storyBoard.teamIndex = 3
                
            default:
                break
            }
            self.navigationController?.pushViewController(storyBoard, animated: true)
        }
    }
    
    
}

enum upcomingApi : String {
    
    case Football = "https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey=44ec41896869760bf9da8e3b2ccd2ea8bca5c24e0269d0102507eed1e78a3ae1&from=2021-05-18&to=2021-05-18"
    case Basketball = "https://apiv2.allsportsapi.com/basketball/?met=Fixtures&APIkey=44ec41896869760bf9da8e3b2ccd2ea8bca5c24e0269d0102507eed1e78a3ae1&from=2022-05-23&to=2022-05-23"
    case Cricket = "https://apiv2.allsportsapi.com/cricket/?met=Fixtures&APIkey=44ec41896869760bf9da8e3b2ccd2ea8bca5c24e0269d0102507eed1e78a3ae1&from=2022-03-13&to=2022-03-13"
    case Tennis = "https://apiv2.allsportsapi.com/tennis/?met=Fixtures&APIkey=44ec41896869760bf9da8e3b2ccd2ea8bca5c24e0269d0102507eed1e78a3ae1&from=2020-06-03&to=2020-06-03"
    
}













