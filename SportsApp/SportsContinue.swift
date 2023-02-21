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
                    
                    self.legImg = self.legImg.map{$0 is NSNull ? "data:image/jpeg;base64,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" : $0}
                    DispatchQueue.main.async {
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
                    DispatchQueue.main.async {
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
