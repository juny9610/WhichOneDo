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
    @IBOutlet var favoriteTable: UITableView!
    var stars:[UserModel.Stars] = []
    public var deletedUid:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        favoriteTable.dataSource = self
        favoriteTable.delegate = self
        favoriteTable.register(UINib.init(nibName: "FavoriteViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteViewCell")
        getStarList()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stars.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell:FavoriteViewCell = favoriteTable.dequeueReusableCell(withIdentifier: "FavoriteViewCell", for: indexPath) as! FavoriteViewCell
        cell.cafeName.text = stars[indexPath.row].cafeName
        return cell
        
    }// 스와이프 삭제
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let uid = Auth.auth().currentUser?.uid
            let v = stars[indexPath.row].cafeName
            Database.database().reference().child("users").child(uid!).child("stars").observe(DataEventType.value, with: {
                (datasnapshot) in
                for child in datasnapshot.children{
                    let fchild = child as! DataSnapshot
                    let starModel = StarModel()
                    starModel.setValuesForKeys(fchild.value as! [String : Any])
                    if starModel.cafeName == v{
                        self.deletedUid = fchild.key
                        print("delete uid: ", self.deletedUid)
                        Database.database().reference().child("users").child(uid!).child("stars").child(self.deletedUid!).removeValue()
                        break
                    }
                }
            })
            self.stars.remove(at: indexPath.row)
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

            print("stars: ", self.stars)
            self.favoriteTable.reloadData()
        })
    }
}
