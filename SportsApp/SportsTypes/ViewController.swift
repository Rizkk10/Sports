//
//  ViewController.swift
//  CollectionViewDemo
//
//  Created by Rezk on 15/02/2023.
//

import UIKit
import Reachability

class ViewController: UIViewController , UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout , UICollectionViewDataSource {
    
    @IBOutlet weak var colView: UICollectionView!
    
    var sportsArr = [Sports]()
    var flag : Int = 0
    let reachability = try! Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colView.delegate = self
        colView.dataSource = self
        
        sportsArr.append(Sports(sportName: "FootBall", sportPhoto: UIImage(named: "football")!))
        sportsArr.append(Sports(sportName: "BasketBall", sportPhoto: UIImage(named: "NewBasketball")!))
        sportsArr.append(Sports(sportName: "Cricket", sportPhoto: UIImage(named: "NewCricket")!))
        sportsArr.append(Sports(sportName: "Tennis", sportPhoto: UIImage(named: "tennis")!))

    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability

        switch reachability.connection {
        case .wifi:
            print("Wifi Connection")
        case .cellular:
            print("Cellular Connection ")
        case .unavailable:
            print("No Connection")
        case .none:
            print("No Connection")
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsArr.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! CollectionViewCell
        let sport = sportsArr[indexPath.row]
        
        cell.setCell(name: sport.sportName, photo: sport.sportPhoto)
        
        
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 120, left: 1, bottom: 20, right: 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        flag = indexPath.row
        
        if (reachability.connection != .unavailable){
            reachInternet()
        }else {
            
            let alert = UIAlertController(title: "No Internet Connection", message: "Please check your connection and try again", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            
            present(alert, animated: true)
            
        }
    }
    
    func reachInternet(){
        let table = self.storyboard?.instantiateViewController(withIdentifier: "SportsTableViewController") as! SportsTableViewController
        table.comeFrom = flag
        if (reachability.connection != .unavailable){
            self.navigationController?.pushViewController(table, animated: true)
        }
    }
}


struct Sports {
    
    var sportName : String
    var sportPhoto : UIImage
    
}

