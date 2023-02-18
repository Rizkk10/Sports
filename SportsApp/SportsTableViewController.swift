import UIKit

class SportsTableViewController: UITableViewController {
    
    var legTitles: [String] = []
    var legCountry: [String] = []
    var data: [[String: Any]] = []
    var comeFrom : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch comeFrom {
            
        case 0 :
            fetchData(apiLink: sportsApi.Football.rawValue)
        case 1:
            fetchData(apiLink: sportsApi.Basketball.rawValue)
        case 2:
            fetchCricketData()
        case 3:
            fetchData(apiLink: sportsApi.Tennis.rawValue)
        default:
            break
        }
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return legTitles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath)
        cell.textLabel?.text = legTitles[indexPath.row]
        cell.textLabel?.font = UIFont(name: "System", size: 22.0)
        cell.detailTextLabel?.text = legCountry[indexPath.row]
        cell.detailTextLabel?.font = UIFont(name: "System", size: 22.0)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let main = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        switch comeFrom {
            
        case 0 :
            main.index = 0
        case 1:
            main.index = 1
        case 2:
            main.index = 2
        case 3:
            main.index = 3
        default:
            break
        }
        self.navigationController?.pushViewController(main, animated: true)
    }
    
    
    
}
