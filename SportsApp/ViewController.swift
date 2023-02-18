//
//  ViewController.swift
//  CollectionViewDemo
//
//  Created by Rezk on 15/02/2023.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout , UICollectionViewDataSource {
    
    @IBOutlet weak var colView: UICollectionView!
    
    var sportsArr = [Sports]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colView.delegate = self
        colView.dataSource = self
        
        sportsArr.append(Sports(sportName: "FootBall", sportPhoto: UIImage(named: "football")!))
        sportsArr.append(Sports(sportName: "BasketBall", sportPhoto: UIImage(named: "Basketball")!))
        sportsArr.append(Sports(sportName: "Cricket", sportPhoto: UIImage(named: "cricket")!))
        sportsArr.append(Sports(sportName: "Tennis", sportPhoto: UIImage(named: "tennis")!))
        
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
        
        let table = self.storyboard?.instantiateViewController(withIdentifier: "SportsTableViewController") as! SportsTableViewController
       
        switch indexPath.row {
            
        case 0 :
            table.comeFrom = indexPath.row
           
            
            self.navigationController?.pushViewController(table, animated: true)
        case 1 :
            table.comeFrom = indexPath.row
            self.navigationController?.pushViewController(table, animated: true)
        case 2:
            table.comeFrom = indexPath.row
            self.navigationController?.pushViewController(table, animated: true)
        case 3 :
            table.comeFrom = indexPath.row
            self.navigationController?.pushViewController(table, animated: true)
        default:
            break
        }
    }
    
}


struct Sports {
    
    var sportName : String
    var sportPhoto : UIImage
    
}

