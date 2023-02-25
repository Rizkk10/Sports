//
//  MainViewController.swift
//  CollectionViewDemo
//
//  Created by Rezk on 16/02/2023.
//

import UIKit
import Alamofire

class MainViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var TeamsLabel: UILabel!
    
    @IBOutlet weak var teamsCell: UICollectionView!
    
    @IBOutlet weak var upComingCell: UICollectionView!
    
    @IBOutlet weak var latestResultsCell: UICollectionView!
    
    
    
    var index : Int = 0
    var legKey : Int = 0
    var dataDetails : DetailsResponse?
    var sportType = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        teamsCell.dataSource = self
        teamsCell.delegate = self
        // to know where i come from
        
        switch index {
            
        case 0 :
            let footBallApi = "https://apiv2.allsportsapi.com/football/?met=Fixtures&APIkey=44ec41896869760bf9da8e3b2ccd2ea8bca5c24e0269d0102507eed1e78a3ae1&from=2022-02-19&to=2023-02-28&leagueId=\(legKey)"
            fetchData(apiLink: footBallApi) { res in
                print("Football")
            }
        case 1:
            let BasketBallApi = "https://apiv2.allsportsapi.com/basketball/?met=Fixtures&APIkey=44ec41896869760bf9da8e3b2ccd2ea8bca5c24e0269d0102507eed1e78a3ae1&from=2022-12-13&to=2023-02-20&leagueId=\(legKey)"
            fetchData(apiLink: BasketBallApi) { res in
                print("Basketball")
            }
        case 2:
            fetchData(apiLink: upcomingApi.Cricket.rawValue) { res in
                print("Cricket")
            }
        case 3:
            fetchData(apiLink: upcomingApi.Tennis.rawValue) { res in
                print("Tennis")
            }
        default:
            break
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        // number of items for teams
        if collectionView == teamsCell {
            print(dataDetails?.result.count ?? 1)
            return dataDetails?.result.count ?? 1
        }
        // number of items for upComing Event
        if collectionView == upComingCell {
            return dataDetails?.result.count ?? 0
            //            return homeTeam.count
        }
        // number of items for latest Result
        return dataDetails?.result.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // cofiguration cell for Teams
        if collectionView == teamsCell {
            
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teams", for: indexPath) as! TeamsCollectionViewCell
            //            cell.backgroundColor = UIColor.red
            
            let team = dataDetails?.result[indexPath.row]
            switch index {
                
                // FootBall
            case 0:
                let url = URL(string: (team?.home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
                cell.teamImage.kf.setImage(with: url)
                
                // Basketball and Cricket
            case 1 , 2:
                let url = URL(string: (team?.event_home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
                cell.teamImage.kf.setImage(with: url)
                
                //tennis
            case 3:
                TeamsLabel.text = "Players"
                let url = URL(string: (team?.event_first_player_logo) ?? "https://i.ibb.co/G9YtDLp/tennis.jpg")
                cell.teamImage.kf.setImage(with: url)
                
            default:
                break
            }
               
            return cell
        }
        
        // cofiguration  cell for upComing Event
        if collectionView == upComingCell {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upComing", for: indexPath) as! UpComingCollectionViewCell
            let team = dataDetails?.result[indexPath.row]
            
            switch index {
            case 0 :
                // FootBall
                cell.configureCell(homeTitle: (team?.event_home_team)! , awayTitle: (team?.event_away_team)!, eventDate: (team?.event_date)! , homeLogo: (team?.home_team_logo)!, awaylogo: (team?.away_team_logo)!, eventTime:(team?.event_time)!)
            case 1 :
                // BasketBall
                let urlHome = URL(string: (team?.home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
                let urlAway = URL(string: (team?.away_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
                cell.configureCell(homeTitle: (team?.event_home_team)!, awayTitle: (team?.event_away_team)!, eventDate: (team?.event_date)! , homeLogo:"" , awaylogo: "", eventTime: (team?.event_time)!)
                cell.homeTeamImageView.kf.setImage(with: urlHome)
                cell.awayTeamImageView.kf.setImage(with: urlAway)
                
            case 2 :
                //Cricket
                cell.configureCell(homeTitle: (team?.event_home_team)!, awayTitle: (team?.event_away_team)!, eventDate: (team?.event_date_stop)! , homeLogo:"" , awaylogo: "", eventTime: (team?.event_time)!)
                let urlHome = URL(string: (team?.event_home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
                cell.homeTeamImageView.kf.setImage(with: urlHome)
                let urlAway = URL(string: (team?.event_away_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
                cell.awayTeamImageView.kf.setImage(with: urlAway)
            case 3 :
                //tennis
                cell.configureCell(homeTitle: (team?.event_first_player)!, awayTitle: (team?.event_second_player)!, eventDate: (team?.event_date)! , homeLogo:"" , awaylogo: "", eventTime: (team?.event_time)!)
                let urlHome = URL(string: (team?.event_first_player_logo) ?? "https://i.ibb.co/G9YtDLp/tennis.jpg")
                cell.homeTeamImageView.kf.setImage(with: urlHome)
                let urlAway = URL(string: (team?.event_second_player_logo) ?? "https://i.ibb.co/G9YtDLp/tennis.jpg")
                cell.awayTeamImageView.kf.setImage(with: urlAway)
                
                
            default :
                break
            }
            return cell
        }
        
        
        
        // cofiguration  cell for Latest Results
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestResults", for: indexPath) as! LatestResultsCollectionViewCell
        let team = dataDetails?.result[indexPath.row + 20 ]
        
        switch index {
            // FootBall
        case 0:
            cell.homeTeamLabel.text = team?.event_home_team
            cell.awayTeamLabel.text = team?.event_away_team
            
            let urlHome = URL(string: (team?.home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
            cell.homeTeamImageView.kf.setImage(with: urlHome)
            let urlAway = URL(string: (team?.away_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
            cell.awayTeamImageView.kf.setImage(with: urlAway)
            
            cell.eventDateLabel.text = team?.event_date
            cell.eventTimeLabel.text = team?.event_time
            cell.eventFinalResultLabel.text = team?.event_final_result
            
            // Basketball
        case 1:
            cell.homeTeamLabel.text = team?.event_home_team
            cell.awayTeamLabel.text = team?.event_away_team
            
            let urlHome = URL(string: (team?.event_home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
            cell.homeTeamImageView.kf.setImage(with: urlHome)
            let urlAway = URL(string: (team?.event_away_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
            cell.awayTeamImageView.kf.setImage(with: urlAway)
            
            cell.eventDateLabel.text = team?.event_date
            cell.eventTimeLabel.text = team?.event_time
            cell.eventFinalResultLabel.text = team?.event_final_result
            
            //Cricket
        case 2:
            cell.homeTeamLabel.text = team?.event_home_team
            cell.awayTeamLabel.text = team?.event_away_team
            
            let urlHome = URL(string: (team?.event_home_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
            cell.homeTeamImageView.kf.setImage(with: urlHome)
            let urlAway = URL(string: (team?.event_away_team_logo) ?? "https://goplexe.org/wp-content/uploads/2020/04/placeholder-1.png")
            cell.awayTeamImageView.kf.setImage(with: urlAway)
            
            cell.eventDateLabel.text = team?.event_date_stop
            cell.eventTimeLabel.text = team?.event_time
            cell.eventFinalResultLabel.text = team?.event_home_final_result
            
            //tennis
        case 3:
            cell.homeTeamLabel.text = team?.event_first_player
            cell.awayTeamLabel.text = team?.event_second_player
            
            let urlHome = URL(string: (team?.event_first_player_logo) ?? "https://i.ibb.co/G9YtDLp/tennis.jpg")
            cell.homeTeamImageView.kf.setImage(with: urlHome)
            let urlAway = URL(string: (team?.event_second_player_logo) ?? "https://i.ibb.co/G9YtDLp/tennis.jpg")
            cell.awayTeamImageView.kf.setImage(with: urlAway)
            
            cell.eventDateLabel.text = team?.event_date
            cell.eventTimeLabel.text = team?.event_time
            cell.eventFinalResultLabel.text = team?.event_final_result
            
        default:
            break
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == upComingCell{
            return CGSize(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/5)
        }
        if collectionView == teamsCell{
            return CGSize(width: 150, height: 150)
        }
        return CGSize(width: UIScreen.main.bounds.width/1.5, height: UIScreen.main.bounds.height/5)
    }
}


