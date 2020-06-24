//
//  FavoriteTableViewController.swift
//  WhichOneDo
//
//  Created by 임성준 on 2020/06/01.
//  Copyright © 2020 강희선. All rights reserved.
//

import UIKit
import Firebase
class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var stars:[UserModel.Stars] = []
    @IBOutlet var favoriteTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTable.dataSource = self
        favoriteTable.delegate = self
        favoriteTable.register(UINib.init(nibName: "FavoriteViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteViewCell")
        //self.tabBarItem.image = UIImage(named: "favorite_tabbar")
        //self.tabBarItem.selectedImage = UIImage(named: "favorite_tabbar")
        getStarList()
        
        favoriteTable.rowHeight = 70
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return stars.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell:FavoriteViewCell = favoriteTable.dequeueReusableCell(withIdentifier: "FavoriteViewCell", for: indexPath) as! FavoriteViewCell
        cell.cafeName.text = stars[indexPath.row].cafeName
        cell.selectionStyle = .none
        return cell
        
    }// 스와이프 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let mapViewController = self.tabBarController?.viewControllers![0] as! MapViewController
        if editingStyle == .delete{
            let uid = Auth.auth().currentUser?.uid
            let v = stars[indexPath.row].cafeName
            Database.database().reference().child("users").child(uid!).child("stars").observeSingleEvent(of: DataEventType.value, with: {
                (datasnapshot) in
                for child in datasnapshot.children{
                    let fchild = child as! DataSnapshot
                    let starModel = StarModel()
                    starModel.setValuesForKeys(fchild.value as! [String : Any])
                    if starModel.cafeName == v{
                        Database.database().reference().child("users").child(uid!).child("stars").child(fchild.key).removeValue()
                        break
                    }
                }
            })
            self.stars.remove(at: indexPath.row)
            mapViewController.mapUpdate()
            self.favoriteTable.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    func getStarList(){
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(uid!).child("stars").observe(DataEventType.value, with: {
            (datasnapshot) in
            self.stars.removeAll()
            for item in datasnapshot.children.allObjects as! [DataSnapshot]{
                let star = UserModel.Stars(JSON: item.value as! [String:Any])
                self.stars.append(star!)
            }
            self.favoriteTable.reloadData()
        })
    }
    func getStarList1(){
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(uid!).child("stars").observe(DataEventType.value, with: {
            (datasnapshot) in
            self.stars.removeAll()
            for item in datasnapshot.children.allObjects as! [DataSnapshot]{
                let star = UserModel.Stars(JSON: item.value as! [String:Any])
                self.stars.append(star!)
            }
        })
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mapViewController = self.tabBarController?.viewControllers![0] as! MapViewController
        let mapView = mapViewController.mapView
        let poiItems = mapViewController.poiItems
        let myPOIItem = poiItems!.filter{(poiItem: MTMapPOIItem) -> Bool in
            let cafe = poiItem.userObject as! CafeModel
            return cafe.cafeName == stars[indexPath.row].cafeName
        }
        print(myPOIItem[0].mapPoint.mapPointGeo())
        mapView?.select(myPOIItem[0], animated: true)
        self.tabBarController?.selectedIndex = 0
        mapViewController.filter.selectedSegmentIndex = 0
        mapView?.setZoomLevel(1, animated: true)
        mapView?.setMapCenter(myPOIItem[0].mapPoint, animated: true)
    }
}
