//
//  MainViewContinue.swift
//  CollectionViewDemo
//
//  Created by Rezk on 17/02/2023.
//

import Foundation
import Alamofire


extension MainViewController {
    
    // fetch football and basketball data
    
    func fetchUpcomingResultData(apiLink : String){
        
        let url = URL(string: apiLink)!
        
        AF.request(url).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let json):
                guard let jsonData = (json as? [String: Any])?["result"] as? [[String: Any]] else {return}
                self.homeTeam = jsonData.compactMap { $0["event_home_team"] as? String }
                self.awayTeam = jsonData.compactMap { $0["event_away_team"] as? String }
                self.awayTeamLogo = jsonData.compactMap { $0["home_team_logo"] as? String }
                self.homeTeamLogo = jsonData.compactMap { $0["away_team_logo"] as? String }
                self.eventDate = jsonData.compactMap { $0["event_date"] as? String }
                self.homeTeamKey = jsonData.compactMap { $0["home_team_key"] as? Int }
                
                
                
                DispatchQueue.main.async {
                    self.upComingCell.reloadData()
                }
                
                print(self.homeTeam[0])
                print(self.awayTeam[0])
                
                
            case .failure(let error) :
                print(error.localizedDescription)
                
                
            }
        })
        
        
    }
    
    // fetch cricket data
    func fetchUpcomingResultCricketData(apiLink : String){
        
        let url = URL(string: apiLink)!
        
        AF.request(url).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let json):
                guard let jsonData = (json as? [String: Any])?["result"] as? [[String: Any]] else {return}
                self.homeTeam = jsonData.compactMap { $0["event_home_team"] as? String }
                self.awayTeam = jsonData.compactMap { $0["event_away_team"] as? String }
                self.awayTeamLogo = jsonData.compactMap { $0["event_away_team_logo"] as? String }
                self.homeTeamLogo = jsonData.compactMap { $0["event_home_team_logo"] as? String }
                self.eventDate = jsonData.compactMap { $0["event_date_start"] as? String }
                self.homeTeamKey = jsonData.compactMap { $0["home_team_key"] as? Int }
                
                
                
                DispatchQueue.main.async {
                    self.upComingCell.reloadData()
                }
                
                print(self.homeTeam[0])
                print(self.awayTeam[0])
                
                
            case .failure(let error) :
                print(error.localizedDescription)
                
                
            }
        })
        
        
    }
    
    // fetch tennis data
    
    func fetchUpcomingResultTennisData(apiLink : String){
        
        let url = URL(string: apiLink)!
        
        AF.request(url).responseJSON(completionHandler: { response in
            switch response.result {
            case .success(let json):
                guard let jsonData = (json as? [String: Any])?["result"] as? [[String: Any]] else {return}
                self.homeTeam = jsonData.compactMap { $0["event_first_player"] as? String }
                self.awayTeam = jsonData.compactMap { $0["event_second_player"] as? String }
                self.awayTeamLogo = jsonData.compactMap { $0["event_second_player_logo"] as? String }
                self.homeTeamLogo = jsonData.compactMap { $0["event_first_player_logo"] as? String }
                self.eventDate = jsonData.compactMap { $0["event_date"] as? String }
                self.homeTeamKey = jsonData.compactMap { $0["first_player_key"] as? Int }
                
                
                
                DispatchQueue.main.async {
                    self.upComingCell.reloadData()
                }
                
                print(self.awayTeamLogo[0])
                print(self.homeTeamLogo[0])
                print(self.homeTeam[0])
                
                
            case .failure(let error) :
                print(error.localizedDescription)
                
                
            }
        })
        
        
    }
}

enum upcomingApi : String {
    
    case Football = "https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey=44ec41896869760bf9da8e3b2ccd2ea8bca5c24e0269d0102507eed1e78a3ae1&from=2021-05-18&to=2021-05-18"
    case Basketball = "https://apiv2.allsportsapi.com/basketball/?met=Fixtures&APIkey=44ec41896869760bf9da8e3b2ccd2ea8bca5c24e0269d0102507eed1e78a3ae1&from=2022-05-23&to=2022-05-23"
    case Cricket = "https://apiv2.allsportsapi.com/cricket/?met=Fixtures&APIkey=44ec41896869760bf9da8e3b2ccd2ea8bca5c24e0269d0102507eed1e78a3ae1&from=2022-03-13&to=2022-03-13"
    case Tennis = "https://apiv2.allsportsapi.com/tennis/?met=Fixtures&APIkey=44ec41896869760bf9da8e3b2ccd2ea8bca5c24e0269d0102507eed1e78a3ae1&from=2020-06-03&to=2020-06-03"
    
}

