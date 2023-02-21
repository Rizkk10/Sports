import UIKit

class SportsTableViewController: UITableViewController {
    
    var legTitles: [String] = []
    var legImg: [Any] = []
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! TableViewCell
        cell.contentView.layer.cornerRadius = 20
        cell.contentView.layer.masksToBounds = true
        
        cell.legLabel.text = legTitles[indexPath.row]

//        cell.legImage.image = UIImage(named: "Basketball")
//        var str:String?
//        str = legImg[indexPath.row] ?? "Basketball"
//        let predicate = NSPredicate(format:"SELF ENDSWITH[c] %@", ".jpg")
//        let result = predicate.evaluate(with: str)
//
//        //MARK: - kingfisher
//        if result{
//            let url = URL(string: str!)
//            cell.legImage.kf.setImage(with: url)
//
//        }else{
//            cell.legImage.image = UIImage(named: "Basketball")
//        }
        
        switch comeFrom {
            
        case 0 :
            var str = legImg[indexPath.row]
            let predicate = NSPredicate(format:"SELF ENDSWITH[c] %@", ".png")
            let result = predicate.evaluate(with: str)
            
            //MARK: - kingfisher
            if result{
                let url = URL(string: str as! String)
                cell.legImage.kf.setImage(with: url)
                
            }else{
                cell.legImage.image = UIImage(named: "Basketball")
            }
        case 1, 2, 3:
            cell.legImage.image = UIImage(named: "Basketball")
        default:
            break
        }
 
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
        
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
