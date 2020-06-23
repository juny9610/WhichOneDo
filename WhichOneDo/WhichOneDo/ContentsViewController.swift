//
//  ContentsViewController.swift
//  WhichOneDo
//
//  Created by 임성준 on 2020/06/21.
//  Copyright © 2020 강희선. All rights reserved.
//

import UIKit
import Firebase
class ContentsViewController: UIViewController {
    
    @IBOutlet var detailUserID: UILabel!
    @IBOutlet var detailTitle: UILabel!
    @IBOutlet var detailContents: UITextView!
    @IBOutlet var detailLikeNum: UILabel!
    @IBOutlet var detailCommentsNum: UILabel!
    @IBOutlet var detailTime: UILabel!
    @IBOutlet var commentsList: UITableView!
    @IBOutlet var comments: UITextField!
    @IBOutlet var btnSend: UIButton!
    @IBOutlet var btnLike: UIButton!
    
    var receiveCommunity : CommunityModel!
    var like: String?
    var like2: Int?
    var communityId: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        let formatter = DateFormatter()
        let write_time_string = formatter.string(from: Date())
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        detailTime.text = write_time_string
        self.navigationController?.navigationBar.tintColor = UIColor.black

        detailUserID.text = receiveCommunity.userId
        detailTitle.text = receiveCommunity.title
        detailContents.text = receiveCommunity.contents
        detailLikeNum.text = receiveCommunity.likeNum
        detailCommentsNum.text = receiveCommunity.commentsNum
        detailTime.text = receiveCommunity.time
        like = receiveCommunity.likeNum
        like2 = Int(like!)
        //commentsList.delegate = self
        //commentsList.dataSource = self
        
        //let nibName = UINib(nibName: "comementsCell", bundle: nil)
        //commentsList.register(nibName, forCellReuseIdentifier: "commentsCell")
    }

    func receiveCommunity(_ item: CommunityModel!, _ item2: String) {
        receiveCommunity = item
        communityId = item2
    }
    
    @IBAction func LikeEvent(_ sender: Any) {
        like2! += 1
        detailLikeNum.text = String(like2!)
        Database.database().reference().child("community").child(communityId!).child("likeNum").setValue(String(like2!))
    }
    
}
