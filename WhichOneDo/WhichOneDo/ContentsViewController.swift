//
//  ContentsViewController.swift
//  WhichOneDo
//
//  Created by 임성준 on 2020/06/21.
//  Copyright © 2020 강희선. All rights reserved.
//

import UIKit

class ContentsViewController: UIViewController/*, UITableViewDelegate, UITableViewDataSource*/ {
    
    @IBOutlet var detailUserID: UILabel!
    @IBOutlet var detailTitle: UILabel!
    @IBOutlet var detailContents: UITextView!
    @IBOutlet var detailLikeNum: UILabel!
    @IBOutlet var detailCommentsNum: UILabel!
    @IBOutlet var detailTime: UILabel!
    
    //@IBOutlet var commentsList: UITableView!
    @IBOutlet var comments: UITextField!
    @IBOutlet var btnSend: UIButton!
    
    var receiveCommunity : CommunityModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = UIColor.black

        detailUserID.text = receiveCommunity.userID
        detailTitle.text = receiveCommunity.title
        detailContents.text = receiveCommunity.contents
        detailLikeNum.text = receiveCommunity.likeNum
        detailCommentsNum.text = receiveCommunity.commentsNum
        detailTime.text = receiveCommunity.time
        
        //commentsList.delegate = self
        //commentsList.dataSource = self
        
        //let nibName = UINib(nibName: "comementsCell", bundle: nil)
        //commentsList.register(nibName, forCellReuseIdentifier: "commentsCell")
    }

    func receiveCommunity(_ item: CommunityModel) {
        receiveCommunity = item
    }
    
}
