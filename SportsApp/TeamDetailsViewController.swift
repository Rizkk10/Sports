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
    @IBOutlet weak var teamImg: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    var sportType = ""
    var teamKey = ""
    var teeamImg = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    
        playersTable.delegate = self
        playersTable.dataSource = self
        
        teamName.layer.cornerRadius = 20.0
        teamName.layer.borderWidth = 0.5
        teamName.layer.borderColor = UIColor.red.cgColor
        teamName.layer.backgroundColor = UIColor.cyan.cgColor
        //fetch data
        fetchData { result in
            DispatchQueue.main.async {
                self.dataTeam = result
                print(self.dataTeam?.result[0].team_name ?? "dd")
                self.teamName.text = self.dataTeam?.result[0].team_name
                //
                let url = URL(string: self.teeamImg)
                self.teamImg.kf.setImage(with: url)
                //
                self.playersTable.reloadData()
            }
        }
        //
    }
}
//MARK: - fetch the data for teams

extension TeamDetailsViewController{
    func fetchData(compilation: @escaping (TeamResponse?) -> Void)
    {

        let baseURL = "https://apiv2.allsportsapi.com"
        let apiKey = "ed1c5c7c52b5fe5d2d9330d77e933c2718b6f8399bc960f0d2be45c42f016d9c"
        let metParam = "Teams&teamId=\(teamKey)"
        //let urlString = "\(baseURL)/\(sportType)/?met=\(metParam)&APIkey=\(apiKey)"
        let urlString = "\(baseURL)/football/?met=\(metParam)&APIkey=\(apiKey)"
        
        AF.request(urlString).response
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
    }
}

extension TeamDetailsViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataTeam?.result[0].players.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerscell", for: indexPath) as! playersTableViewCell
        
        let player =  dataTeam?.result[0].players[indexPath.row]
        cell.playerName.text = player?.player_name
        cell.playerNumber.text = player?.player_number
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
            switch sportType {
            case "football":
                cell.playerImg.image = UIImage(named: "1")
            case "basketball":
                cell.playerImg.image = UIImage(named: "2")
            case "cricket":
                cell.playerImg.image = UIImage(named: "3")
            case "tennis":
                cell.playerImg.image = UIImage(named: "4")
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

