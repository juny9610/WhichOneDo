//
//  CommunityTableViewController.swift
//  WhichOneDo
//
//  Created by 임성준 on 2020/06/21.
//  Copyright © 2020 강희선. All rights reserved.
//

import UIKit
import Firebase

class CommunityTableViewController: UITableViewController {
    
    var communityList : [CommunityModel] = []
  
    @IBOutlet var communityListTable: UITableView!
    @IBOutlet var btnWrite: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        communityListTable.delegate = self
        communityListTable.dataSource = self
        
        let nibName = UINib(nibName: "CommunityTableViewCell", bundle: nil)
        communityListTable.register(nibName, forCellReuseIdentifier: "communityCell")
        communityListTable.rowHeight = 100
        
        self.btnWrite.image = UIImage(named: "write")

        getContents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        communityListTable.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communityList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "communityCell", for: indexPath) as! CommunityTableViewCell

        cell.title.text = communityList[indexPath.row].title
        cell.time.text = communityList[indexPath.row].time
        cell.userID.text = communityList[indexPath.row].userId
        cell.likeNum.text = communityList[indexPath.row].likeNum
        cell.commentsNum.text = communityList[indexPath.row].commentsNum

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contentsview = storyboard?.instantiateViewController(identifier: "ContentsViewController") as? ContentsViewController
        contentsview?.receiveCommunity(communityList[indexPath.row])
        self.present(contentsview!, animated: true, completion: nil)
    }
    
    @objc func Write() {
        let view = storyboard?.instantiateViewController(identifier: "write") as! WriteViewController
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: true, completion: nil)
    }
    func getContents(){
        
        Database.database().reference().child("community").observe(DataEventType.value, with:{ (datasnapshot) in
            self.communityList.removeAll()
            for child in datasnapshot.children{
                let fchild = child as! DataSnapshot
                let communityModel = CommunityModel()
                communityModel.setValuesForKeys(fchild.value as! [String:Any])
                self.communityList.append(communityModel)
            }
            DispatchQueue.main.async {
                self.communityListTable.reloadData()
            }
        })
    }

}

