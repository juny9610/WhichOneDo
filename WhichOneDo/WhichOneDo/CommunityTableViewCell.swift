//
//  CommunityTableViewCell.swift
//  WhichOneDo
//
//  Created by 임성준 on 2020/06/21.
//  Copyright © 2020 강희선. All rights reserved.
//

import UIKit

class CommunityTableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var time: UILabel!
    @IBOutlet var userID: UILabel!
    @IBOutlet var likeNum: UILabel!
    @IBOutlet var commentsNum: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
