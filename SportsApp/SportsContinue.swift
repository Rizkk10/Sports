//
//  SportsContinue.swift
//  CollectionViewDemo
//
//  Created by Rezk on 16/02/2023.
//

import Foundation

extension SportsTableViewController {
    
  
    func fetchData(apiLink : String) {
        guard let url = URL(string: "\(apiLink)") else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let result = (json as? [String: Any])?["result"] as? [[String: Any]] {
                    self.data = result
                    self.legTitles = result.compactMap { $0["league_name"] as? String }
                    self.legCountry = result.compactMap { $0["country_name"] as? String }
                    self.legImg = result.compactMap { $0["league_logo"] as? Any }
                    self.legKey = result.compactMap { $0["league_key"] as? Int }
                    
                    self.legImg = self.legImg.map{$0 is NSNull ? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png" : $0}
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    
    
    func fetchCricketData() {
        guard let url = URL(string: sportsApi.Cricket.rawValue) else {
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let result = (json as? [String: Any])?["result"] as? [[String: Any]] {
                    self.data = result
                    self.legTitles = result.compactMap { $0["league_name"] as? String }
                    self.legCountry = result.compactMap { $0["league_year"] as? String }
                    self.legImg = result.compactMap { $0["league_logo"] as? String }
                    self.legKey = result.compactMap { $0["league_key"] as? Int }
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    enum sportsApi : String {
        
        case Football = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=44ec41896869760bf9da8e3b2ccd2ea8bca5c24e0269d0102507eed1e78a3ae1"
        case Basketball = "https://apiv2.allsportsapi.com/basketball/?met=Leagues&APIkey=44ec41896869760bf9da8e3b2ccd2ea8bca5c24e0269d0102507eed1e78a3ae1"
        case Cricket = "https://apiv2.allsportsapi.com/cricket/?met=Leagues&APIkey=44ec41896869760bf9da8e3b2ccd2ea8bca5c24e0269d0102507eed1e78a3ae1"
        case Tennis = "https://apiv2.allsportsapi.com/tennis/?met=Leagues&APIkey=44ec41896869760bf9da8e3b2ccd2ea8bca5c24e0269d0102507eed1e78a3ae1"
        
    }
    
}
