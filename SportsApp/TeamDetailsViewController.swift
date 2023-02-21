//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Dragon on 20/02/2023.
//

import UIKit
import Alamofire

class TeamDetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    //variable to response data
    @IBOutlet weak var playersTable: UITableView!
    var dataTeam : TeamResponse?
    var playerData : TeamResponseNew?
    @IBOutlet weak var teamImg: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    
    var teamIndex = 0
    var sportType = ""
    var teamKey = ""
    var teeamImg = ""
    
    
    var favArray = [String]()
    
    var keyFav = ""
    var keyNotFav = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playersTable.delegate = self
        playersTable.dataSource = self
        
        teamName.layer.cornerRadius = 20.0
        teamName.layer.borderWidth = 0.5
        teamName.layer.borderColor = UIColor.red.cgColor
        teamName.layer.backgroundColor = UIColor.cyan.cgColor
        
        //fetch data
        fetchPlayerData {  result in
            DispatchQueue.main.async {
                self.playerData = result
                
                self.keyFav = "\(self.teamKey)"
                self.keyNotFav = "\(self.teamKey)"
                print(self.keyFav)
                print(self.keyNotFav)
                if UserDefaults.standard.bool(forKey: self.keyFav){
                    self.favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    print("add fav")
                }else if UserDefaults.standard.bool(forKey: self.keyNotFav){
                    self.favButton.setImage(UIImage(systemName: "heart"), for: .normal)
                    print("not fav")
                }
                
                self.playersTable.reloadData()
            }
        }
        fetchData { result in
            DispatchQueue.main.async {
                self.dataTeam = result
                self.teamName.text = self.dataTeam?.result[0].team_name
                let url = URL(string: (self.dataTeam?.result[0].team_logo) ?? "football")
                self.teamImg.kf.setImage(with: url)
                
                self.keyFav = "\(self.teamKey)"
                self.keyNotFav = "\(self.teamKey)"
                print(self.keyFav)
                print(self.keyNotFav)
                if UserDefaults.standard.bool(forKey: self.keyFav){
                    self.favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                    print("add fav")
                }else if UserDefaults.standard.bool(forKey: self.keyNotFav){
                    self.favButton.setImage(UIImage(systemName: "heart"), for: .normal)
                    print("not fav")
                }
                
                
            }
        }
        //
        print(favArray)
    }
    
    
    
    @IBAction func favButtonAction(_ sender: Any) {
        //add to fav
        if (favButton.configuration?.image == UIImage(systemName: "heart")){
            self.favButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favArray.append(teamName.text!)
            print("add to fav")
            UserDefaults.standard.set(false, forKey: keyNotFav)
            UserDefaults.standard.set(true, forKey: keyFav)
        }
        //remove from fav
        else if (favButton.configuration?.image == UIImage(systemName: "heart.fill")){
            self.favButton.setImage(UIImage(systemName: "heart"), for: .normal)
            print("remove to fav")
            UserDefaults.standard.set(true, forKey: keyNotFav)
            UserDefaults.standard.set(false, forKey: keyFav)
            
        }
    }
    
    
}
//MARK: - fetch the data for teams

extension TeamDetailsViewController{
    func fetchData(compilation: @escaping (TeamResponse?) -> Void){
        let footUrl =  "https://apiv2.allsportsapi.com/football/?met=Teams&teamId=\(teamKey)&APIkey=ed1c5c7c52b5fe5d2d9330d77e933c2718b6f8399bc960f0d2be45c42f016d9c"
        let basketUrl =  "https://apiv2.allsportsapi.com/basketball/?met=Teams&teamId=\(teamKey)&APIkey=ed1c5c7c52b5fe5d2d9330d77e933c2718b6f8399bc960f0d2be45c42f016d9c"
        let cricketUrl =  "https://apiv2.allsportsapi.com/cricket/?met=Teams&teamId=\(teamKey)&APIkey=ed1c5c7c52b5fe5d2d9330d77e933c2718b6f8399bc960f0d2be45c42f016d9c"
        let tennisUrl =  "https://apiv2.allsportsapi.com/tennis/?met=Players&playerId=\(teamKey)&APIkey=ed1c5c7c52b5fe5d2d9330d77e933c2718b6f8399bc960f0d2be45c42f016d9c"
        
        switch teamIndex {
        case 0 :
            AF.request(footUrl).response
            { response in
                if let data = response.data {
                    do{
                        let result = try JSONDecoder().decode(TeamResponse.self, from: data)
                        compilation(result)
                    }
                    catch{
                        compilation(nil)
                    }
                } else {
                    compilation(nil)
                }
            }
        case 1 :
            AF.request(basketUrl).response
            { response in
                if let data = response.data {
                    do{
                        let result = try JSONDecoder().decode(TeamResponse.self, from: data)
                        compilation(result)
                    }
                    catch{
                        compilation(nil)
                    }
                } else {
                    compilation(nil)
                }
            }
        case 2 :
            AF.request(cricketUrl).response
            { response in
                if let data = response.data {
                    do{
                        let result = try JSONDecoder().decode(TeamResponse.self, from: data)
                        compilation(result)
                    }
                    catch{
                        compilation(nil)
                    }
                } else {
                    compilation(nil)
                }
            }
        case 3:
            AF.request(tennisUrl).response
            { response in
                if let data = response.data {
                    do{
                        let result = try JSONDecoder().decode(TeamResponse.self, from: data)
                        compilation(result)
                    }
                    catch{
                        compilation(nil)
                    }
                } else {
                    compilation(nil)
                }
            }
        default:
            break
        }
    }
    
}

extension TeamDetailsViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playerData?.result[0].players.count ?? 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerscell", for: indexPath) as! playersTableViewCell
        
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.masksToBounds = true
        
        let player =  playerData?.result[0].players[indexPath.row]
        cell.playerName.text = player?.player_name ?? "Unknown"
        cell.playerNumber.text = player?.player_number ?? "Unknown"
        
        //MARK: - predicate
        let string = player?.player_image
        let predicate = NSPredicate(format:"SELF ENDSWITH[c] %@", ".jpg")
        let result = predicate.evaluate(with: string)
        //        print(result) // true
        //MARK: - kingfisher
        if result{
            let url = URL(string: (player?.player_image)!)
            cell.playerImg.kf.setImage(with: url)
        }else
        {
            switch teamIndex {
            case 0 :
                cell.playerImg.image = UIImage(named: "football")
            case 1 :
                cell.playerImg.image = UIImage(named: "Basketball")
            case 2 :
                cell.playerImg.image = UIImage(named: "cricket")
            case 3 :
                cell.playerImg.image = UIImage(named: "tennis")
            default:
                break
            }
        }
        //MARK: - make the cell look round
        //cell.contentView.layer.cornerRadius = cell.contentView.frame.height / 2.5
        //make the image look round
        //cell.playerImg.layer.cornerRadius = cell.playerImg.frame.height / 2.5
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension TeamDetailsViewController {
    
    func fetchPlayerData(compilation: @escaping (TeamResponseNew?) -> Void){
        let footUrl =  "https://apiv2.allsportsapi.com/football/?met=Teams&teamId=\(teamKey)&APIkey=ed1c5c7c52b5fe5d2d9330d77e933c2718b6f8399bc960f0d2be45c42f016d9c"
        let basketUrl =  "https://apiv2.allsportsapi.com/basketball/?met=Teams&teamId=\(teamKey)&APIkey=ed1c5c7c52b5fe5d2d9330d77e933c2718b6f8399bc960f0d2be45c42f016d9c"
        let cricketUrl =  "https://apiv2.allsportsapi.com/cricket/?met=Teams&teamId=\(teamKey)&APIkey=ed1c5c7c52b5fe5d2d9330d77e933c2718b6f8399bc960f0d2be45c42f016d9c"
        let tennisUrl =  "https://apiv2.allsportsapi.com/tennis/?met=Players&playerId=\(teamKey)&APIkey=ed1c5c7c52b5fe5d2d9330d77e933c2718b6f8399bc960f0d2be45c42f016d9c"
        
        switch teamIndex {
        case 0 :
            AF.request(footUrl).response
            { response in
                if let data = response.data {
                    do{
                        let result = try JSONDecoder().decode(TeamResponseNew.self, from: data)
                        compilation(result)
                    }
                    catch{
                        compilation(nil)
                    }
                } else {
                    compilation(nil)
                }
            }
        case 1 :
            AF.request(basketUrl).response
            { response in
                if let data = response.data {
                    do{
                        let result = try JSONDecoder().decode(TeamResponseNew.self, from: data)
                        compilation(result)
                    }
                    catch{
                        compilation(nil)
                    }
                } else {
                    compilation(nil)
                }
            }
        case 2 :
            AF.request(cricketUrl).response
            { response in
                if let data = response.data {
                    do{
                        let result = try JSONDecoder().decode(TeamResponseNew.self, from: data)
                        compilation(result)
                    }
                    catch{
                        compilation(nil)
                    }
                } else {
                    compilation(nil)
                }
            }
        case 3:
            AF.request(tennisUrl).response
            { response in
                if let data = response.data {
                    do{
                        let result = try JSONDecoder().decode(TeamResponseNew.self, from: data)
                        compilation(result)
                    }
                    catch{
                        compilation(nil)
                    }
                } else {
                    compilation(nil)
                }
            }
        default:
            break
        }
    }
}
