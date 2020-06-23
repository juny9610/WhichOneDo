//
//  ContentsViewController.swift
//  WhichOneDo
//
//  Created by 임성준 on 2020/06/21.
//  Copyright © 2020 강희선. All rights reserved.
//

import UIKit

class ContentsViewController: UIViewController {

    @IBOutlet var detailUserID: UILabel!
    @IBOutlet var detailTitle: UILabel!
    @IBOutlet var detailContents: UITextView!
    @IBOutlet var detailLikeNum: UILabel!
    @IBOutlet var detailCommentsNum: UILabel!
    @IBOutlet var detailTime: UILabel!
    @IBOutlet var commentsList: UITableView!
    
    var receiveCommunity : CommunityModel!
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
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func receiveCommunity(_ item: CommunityModel!) {
        receiveCommunity = item
    }
    
}
